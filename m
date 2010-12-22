From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 22 Dec 2010 08:56:14 +0100
Subject: [PATCH v2] i.MX51 Framebuffer support
In-Reply-To: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	(Sascha Hauer's message of "Mon, 20 Dec 2010 11:48:38 +0100")
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87bp4eb5r5.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

Hi,

> The following series adds i.MX51 framebuffer support based on the IPUv3. It
> is not perfect but I decided it is good enough to open it for a wider audience
> and collect first reviews. I tested this on a babbage board using both outputs
> (VGA/DVI) with different resolutions up to 1680x1050 and different colour depths.
> I also tested it on one custom board using a fixed display setting.

After adding code to my efika sb machine file and your patchset, I've
seen the light. Err, no. It was a penguin and a login prompt.  I guess
it means your patchset is working here.

btw, would be nice to add some comments/docs about :
- the meaning of the fields of the imx_ipuv3_platform_data struct. it's
not clear
- same for .display field of the ipuv3_fb_platform_data

Arnaud
