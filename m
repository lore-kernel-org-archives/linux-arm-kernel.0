From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 17:37:51 -0600
Subject: [PATCH 2/8] dt-bindings: gpu: mali: Add optional memory-region
In-Reply-To: <49fd36f667c5ae46b0724c8204eabc51014aab92.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <49fd36f667c5ae46b0724c8204eabc51014aab92.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170215233751.2sin5acaylsb5nqf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 05:39:16PM +0100, Maxime Ripard wrote:
> The reserved memory bindings allow us to specify which memory areas our
> buffers can be allocated from.
> 
> Let's use it.

You didn't think of this when you just added Mali binding? 

> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
>  1 file changed, 4 insertions(+), 0 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
