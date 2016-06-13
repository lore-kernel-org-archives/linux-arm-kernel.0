From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jun 2016 10:54:09 +0800
Subject: [PATCH 01/11] clk: imx: clk-pllv3: fix incorrect handle of enet
 powerdown bit
In-Reply-To: <CAA+hA=SuPhCnieX1w5Rm6AtypvbiBHmD=HUFOOmiicT9Px-dFw@mail.gmail.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <CAA+hA=SuPhCnieX1w5Rm6AtypvbiBHmD=HUFOOmiicT9Px-dFw@mail.gmail.com>
Message-ID: <20160613025409.GH20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 10:56:38PM +0800, Dong Aisheng wrote:
> Hi Shawn,
> 
> On Wed, Jun 8, 2016 at 10:33 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> > After commit f53947456f98 ("ARM: clk: imx: update pllv3 to support imx7"),
> > the former used BM_PLL_POWER bit is not correct anymore for IMX7 ENET.
> > Instead, pll->powerdown holds the correct bit, so using powerdown bit
> > in clk_pllv3_{prepare | unprepare} functions.
> >
> > Fixes: f53947456f98 ("ARM: clk: imx: update pllv3 to support imx7")
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Any comments about this one?

Sorry.  I thought I had applied it.  Applied it now, thanks.

Shawn
