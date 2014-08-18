From: carlo@caione.org (Carlo Caione)
Date: Mon, 18 Aug 2014 15:31:35 +0200
Subject: [PATCH 6/7] ARM: meson: update defconfigs
In-Reply-To: <53F1D5FA.1040803@gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-7-git-send-email-carlo@caione.org>
 <53F1D5FA.1040803@gmail.com>
Message-ID: <20140818133135.GB28819@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 12:31:22PM +0200, Matthias Brugger wrote:
> 
> 
> On 17/08/14 12:49, Carlo Caione wrote:
> >This patch updates the multi_v7_defconfig with the CONFIG_* needed by
> >the just added Meson anch. It also adds a new defconfig specifically for
> >the Meson SoCs.
> >
> >Signed-off-by: Carlo Caione <carlo@caione.org>
> >---
> >  arch/arm/configs/meson_defconfig    | 99 +++++++++++++++++++++++++++++++++++++
> >  arch/arm/configs/multi_v7_defconfig |  3 ++
> >  2 files changed, 102 insertions(+)
> >  create mode 100644 arch/arm/configs/meson_defconfig
> >
> >diff --git a/arch/arm/configs/meson_defconfig b/arch/arm/configs/meson_defconfig
> >new file mode 100644
> >index 0000000..3c9d976
> >--- /dev/null
> >+++ b/arch/arm/configs/meson_defconfig
> 
> I doubt that we need a meson_defconfig when we can get the SoC up
> and running using multi_v7_defconfig.

It was because multi_v7_defconfig is becoming a bit too crowded. But
I'll get rid of it in v2.

Thank you,

-- 
Carlo Caione
