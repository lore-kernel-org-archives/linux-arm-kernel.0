From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 07:46:59 -0500
Subject: [PATCH v3 3/3] arm: mvebu: enable gpio expander over i2c on
 Mirabox platform
In-Reply-To: <CACRpkdbBOQ_KE001kfORapo9=WiJYn04MmRhxnn-5v8ki-EeyA@mail.gmail.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-4-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkdbBOQ_KE001kfORapo9=WiJYn04MmRhxnn-5v8ki-EeyA@mail.gmail.com>
Message-ID: <20130125124659.GH1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Fri, Jan 25, 2013 at 09:17:57AM +0100, Linus Walleij wrote:
> On Tue, Jan 22, 2013 at 10:10 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
> 
> > The Globalscale Mirabox platform can be connected to the JTAG/GPIO box
> > through the Multi-IO port. The GPIO box use the NXP PCA9505 I/O port
> > expansion IC to provide 40-bit parallel input/output GPIOs. This patch
> > enable the use of this expander on the Mirabox.
> >
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> So as requested I leave this patch for now, tell me if you want it
> applied through pinctrl.

Which branch did you put the first two on?  I'm not seeing them.

thx,

Jason.
