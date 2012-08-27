From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Aug 2012 10:30:21 +0200
Subject: [PATCH 4/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <5037A4B3.7030001@gmail.com>
References: <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
 <5037A4B3.7030001@gmail.com>
Message-ID: <20120827083021.GB26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Fri, Aug 24, 2012 at 05:58:43PM +0200, Dirk Behme wrote:
> >
> >Matt, I think you also have video support for efikamx, don't you?
> >
> >Is there a plan to merge all these developments into upstream?
> 
> It's my understanding that Richard is looking at the VPU for i.MX6,
> based on Sascha's IPU patches (this thread) and Javier Martin's
> i.MX27 coda patches.

The VPU has no dependencies on the IPU, it's completely orthogonal.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
