From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:54:54 -0600
Subject: [PATCH 1/2] ARM: dts: am43x-epos-evm: Add the am438 compatible
 string
In-Reply-To: <1455773381-11839-2-git-send-email-j-keerthy@ti.com>
References: <1455773381-11839-1-git-send-email-j-keerthy@ti.com>
 <1455773381-11839-2-git-send-email-j-keerthy@ti.com>
Message-ID: <20160222025454.GP15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 10:59:40AM +0530, Keerthy wrote:
> The SoCs on am43x-epos-evm are named am438x.
> Hence add the compatibility string and remove the am4372 string.

Presumably nothing is using these strings ATM for matching.

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
