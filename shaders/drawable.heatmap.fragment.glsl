in vec2 v_extrude;

layout (std140) uniform HeatmapEvaluatedPropsUBO {
    highp float u_weight;
    highp float u_radius;
    highp float u_intensity;
    lowp float pad0_;
};

#pragma mapbox: define highp float weight

// Gaussian kernel coefficient: 1 / sqrt(2 * PI)
#define GAUSS_COEF 0.3989422804014327

void main() {
    #pragma mapbox: initialize highp float weight

    // Kernel density estimation with a Gaussian kernel of size 5x5
    float d = -0.5 * 3.0 * 3.0 * dot(v_extrude, v_extrude);
    float val = weight * u_intensity * GAUSS_COEF * exp(d);

    fragColor = vec4(val, 1.0, 1.0, 1.0);

#ifdef OVERDRAW_INSPECTOR
    fragColor = vec4(1.0);
#endif
}
