From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 May 2012 10:13:02 +0800
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add imx53 pinctrl driver
In-Reply-To: <CACRpkdaKAF8bznd-sBdcGfdJW_cHSUGFZhnVk4qJ_0LJ8GoUuQ@mail.gmail.com>
References: <1337010369-28687-1-git-send-email-b29396@freescale.com>
 <CACRpkdbW8eeq0gFTjPRpKesmV4K5zqRHuW6C-UywBn8AtqOLCg@mail.gmail.com>
 <20120515112732.GB10347@shlinux2.ap.freescale.net>
 <CACRpkdaKAF8bznd-sBdcGfdJW_cHSUGFZhnVk4qJ_0LJ8GoUuQ@mail.gmail.com>
Message-ID: <20120516021301.GA21517@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 02:33:58PM +0200, Linus Walleij wrote:
> On Tue, May 15, 2012 at 1:27 PM, Dong Aisheng
> <aisheng.dong@freescale.com> wrote:
> > On Tue, May 15, 2012 at 07:10:58PM +0800, Linus Walleij wrote:
> >> Dong, will you merge the i.MX stuff through pinctrl or through
> >> ARM SoC?
> >
> > This patch has no dependency on any arm soc stuffs.
> > I think it's ok to go through pinctrl.
> 
> OK I'll be merging them, I was just thinking if you planned to also
> make machine changes in this kernel cycle.
> 
With the patches going in via pinctrl tree, we can start making machine
changes from next cycle.

-- 
Regards,
Shawn
