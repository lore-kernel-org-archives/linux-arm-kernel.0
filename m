From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 3 Dec 2009 20:36:39 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <37367b3a0912030821w22f72bd1tf200646e32da2158@mail.gmail.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
	<4B16D861.6090307@warmcat.com>
	<37367b3a0912030645m12db4f12j7991081e7d2bca00@mail.gmail.com>
	<4B17D104.4040800@warmcat.com>
	<37367b3a0912030821w22f72bd1tf200646e32da2158@mail.gmail.com>
Message-ID: <20091203193639.GF22533@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 02:21:17PM -0200, Alan Carvalho de Assis wrote:
> On 12/3/09, Andy Green <andy@warmcat.com> wrote:
> >
> > You're super welcome... glad that time spent wandering in the desert was
> > able to help someone else in the end :-)
> >
> 
> Yes, it was a big saga, but finally it is working very nice.
> 
> Now we need few things to get a good imx27 support in the kernel. I
> think the camera and the VPU support are the most important drivers
> missing.
> 
> I think mx1_camera.c could be modified to support mx27 CSI, but to the
> VPU I have no idea.

Sascha has CSI drivers for the MX27, but I'm not sure in which state
they are.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
