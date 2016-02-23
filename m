From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Feb 2016 14:26:12 -0600
Subject: [PATCH 1/3] thermal: exynos: List vtmu-supply as optional
 property in DT binding
In-Reply-To: <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20160223202612.GA10733@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 03:19:09PM -0300, Javier Martinez Canillas wrote:
> The Exynos Thermal Management Unit binding says that the vtmu-supply
> is optional but is listed in the required properties section. Add an
> optional properties section and move the regulator property there.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
