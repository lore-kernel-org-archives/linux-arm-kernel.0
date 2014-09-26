From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 26 Sep 2014 09:20:49 +0200
Subject: [PATCH RFC 0/2] ARM: imx: ventana: enable LDO-bypass mode
In-Reply-To: <1411711172-16498-1-git-send-email-tharvey@gateworks.com>
References: <1411711172-16498-1-git-send-email-tharvey@gateworks.com>
Message-ID: <542513D1.7060806@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

Am 26.09.2014 um 07:59 schrieb Tim Harvey:
> The IMX6 has some internal LDO regulators provided by the anatop regulator
> block that can regulate the arm, soc, gpu/vpu core supplies. Alternatively a
> design can supply vdd_arm and vdd_soc externally via a PMIC to provide a lower
> power draw (switches are more efficient that ldo's).
>
> [...]
>
> I've cc'd the authors of the original commits of the above device-trees as
> they likely have an interest in LDO-bypass mode.

please cc devicetree at vger.kernel.org for your patches.

>
> Tim Harvey (2):
>   regulator: anatop: allow LDO bypass to be set from device-tree
>   ARM: imx: ventana: enable LDO bypass mode for GW54xx
>
>  .../bindings/regulator/anatop-regulator.txt        |  1 +
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              | 63 ++++++++++++++++------
>  drivers/regulator/anatop-regulator.c               |  4 +-
>  3 files changed, 51 insertions(+), 17 deletions(-)
>

Best regards
Stefan
