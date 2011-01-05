From: julien.boibessot@free.fr (Julien Boibessot)
Date: Wed, 05 Jan 2011 14:04:20 +0100
Subject: [PATCH v2] i.MX51 Framebuffer support
In-Reply-To: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4D246C54.9060503@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sascha Hauer a ?crit :
> The following series adds i.MX51 framebuffer support based on the IPUv3. It
> is not perfect but I decided it is good enough to open it for a wider audience
> and collect first reviews. I tested this on a babbage board using both outputs
> (VGA/DVI) with different resolutions up to 1680x1050 and different colour depths.
> I also tested it on one custom board using a fixed display setting.
>   
This driver is also working fine for me on a custom i.MX51 board with a
800x480 18 bits TFT LCD (16bpp mode).

The only strange thing I noticed was a kind of uggly sprite/artefact
(32x32, I would say) appearing at the same time as the Linux console. I
think it may be related to a hardware cursor badly (?) initialised, but
I didn't find a fix yet.
It disappears when I launch a graphical application (Qt or SDL).

Regards,
Julien
