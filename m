From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jul 2013 08:03:48 -0300
Subject: [PATCH v2] ARM: imx: Kconfig: Select ARM1136 related errata
In-Reply-To: <20130712074946.GD25501@S2101-09.ap.freescale.net>
References: <1373552782-14196-1-git-send-email-fabio.estevam@freescale.com>
 <20130712074946.GD25501@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5DhyXp5arkLTHO+MZaA3hrMX4q6Y3OH3LeVfUiizytoAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 4:49 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Jul 11, 2013 at 11:26:22AM -0300, Fabio Estevam wrote:
>> CONFIG_ARM_ERRATA_411920 and CONFIG_ARM_ERRATA_364296 should be selected for
>> ARM1136 SoCs.
>>
> Per help text of the erratums, 364296 affects ARM1136 r0p2, and 411920
> affects ARM1136 before r1p4.  Do you know the revisions used on imx31
> and imx35?  Or do you see that enabling the workaround help fix some
> real issues?

I haven't checked the exact revisions of mx31/mx35.

The reason I selected these two errata was due to comparison with the
FSL BSP defconfig for mx31:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/configs/imx31_3stack_defconfig?h=imx_2.6.31
