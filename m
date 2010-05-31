From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 31 May 2010 10:40:00 +0100
Subject: i.MX SSI Kconfig fixes
In-Reply-To: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1275298800.3174.1.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-31 at 10:49 +0200, Sascha Hauer wrote:
> Hi,
> 
> Two small fixes for i.MX SSI.
> 
> Sascha
> 
> The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> 
>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git imx-ssi-fixes
> 
> Sascha Hauer (2):
>       i.MX ssi: MX31ads sound support should depend on MACH_MX31ADS
>       i.MX ssi: Add missing Kconfig entry for Phytec boards
> 
>  sound/soc/imx/Kconfig |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
