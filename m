From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 28 Jul 2018 18:32:47 +0800
Subject: [GIT PULL 6/6] i.MX defconfig updates for 4.19
In-Reply-To: <20180721215743.gvdyejag6fere6lp@localhost>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
 <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
 <1532140671-2869-3-git-send-email-shawnguo@kernel.org>
 <20180721215743.gvdyejag6fere6lp@localhost>
Message-ID: <20180728103245.GA3481@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 02:57:43PM -0700, Olof Johansson wrote:
> On Sat, Jul 21, 2018 at 10:37:51AM +0800, Shawn Guo wrote:
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> > 
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.19
> > 
> > for you to fetch changes up to eaed0291c62f7b513ad9483b02efdccd4ae4e9fc:
> > 
> >   ARM: imx_v6_v7_defconfig: add DMATEST support (2018-07-21 09:58:21 +0800)
> > 
> > ----------------------------------------------------------------
> > i.MX defconfig update for 4.19:
> >  - Enable ISL29018 sensor and MMA8452 accelerometer driver support for
> >    imx6qdl-sabreauto board.
> >  - Enable DMATEST support which is useful for DMA driver development
> >    testing.
> >  - Use the DRM driver for MXSFB LCD controller found on i.MX23, i.MX28,
> >    i.MX6SX and i.MX7 SoCs.
> 
> Should some of these be added in multi_v7 defconfig too?

>From what I have seen, multi_v7_defconfig is usually used for booting
test on i.MX platforms, and for full feature build imx_v6_v7_defconfig
is used more often.  But we are happy to add things into
multi_v7_defconfig when we see need from people.

> Merged.

Thanks.

Shawn
