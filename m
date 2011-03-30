From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Mar 2011 10:05:53 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <87aagdrqne.fsf@lebrac.rtp-net.org>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
	<87aagdrqne.fsf@lebrac.rtp-net.org>
Message-ID: <20110330080553.GS7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 09:52:53AM +0200, Arnaud Patard wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> Hi,
> 
> > On Wed, Mar 30, 2011 at 02:05:28PM +0800, Richard Zhao wrote:
> >> From: Richard Zhao <richard.zhao@linaro.org>
> >> 
> >> Add mxc_gpu devices for imx35/50/51/53, so external gpu driver module built
> >> for the kernel can work.
> >
> > Why do we need this? I have never seen a driver for this.
> >
> 
> From the subject, I guess it's a patch to declare the device used by the
> driver for the AMD z160 gpu found on theses imx SoCs. iirc, this driver by
> itself is GPL but relies on closed-source userspace stuff, that's imho why
> you didn't see a driver for it. I think you can find it in fsl tree
> inside drivers/mxc/ directory.

I should have been more specific. My open-source eyes have never seen a
driver for this. That's why we shouldn't add support code for this into
mainline.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
