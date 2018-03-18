From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:49:19 -0500
Subject: [PATCH] ARM: dts: sun8i-h3: Add Mali node
In-Reply-To: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180318000635.vy64qrzkmqkl7gbj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 11:16:45AM +0100, Giulio Benetti wrote:
> The H3 has an ARM Mali 400 GPU, so add binding to our DT.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  1 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    | 27 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
