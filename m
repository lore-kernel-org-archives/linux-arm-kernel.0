From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 17:42:07 -0600
Subject: [PATCH 6/8] dt-bindings: gpu: mali: Add optional OPPs
In-Reply-To: <29cb6b892a6e7002d2f6271157a5efa648b0dd9b.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <29cb6b892a6e7002d2f6271157a5efa648b0dd9b.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170215234207.xyuw3wxryi3fdq3o@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 05:39:20PM +0100, Maxime Ripard wrote:
> The operating-points-v2 binding gives a way to provide the OPP of the GPU.
> Let's use it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
>  1 file changed, 4 insertions(+), 0 deletions(-)

Bindings should not unnecessarily evolve. The h/w does not evolve in 
this way. This should have been part of the original binding given that 
it was just added.

Acked-by: Rob Herring <robh@kernel.org>
