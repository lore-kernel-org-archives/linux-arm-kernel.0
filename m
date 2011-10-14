From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 14 Oct 2011 09:27:17 +0200
Subject: [PATCH 0/8] S3C2416: Enable armdiv and armclk
In-Reply-To: <085f01cc8a40$df7af8a0$9e70e9e0$%kim@samsung.com>
References: <201109281217.33813.heiko@sntech.de>
	<085f01cc8a40$df7af8a0$9e70e9e0$%kim@samsung.com>
Message-ID: <201110140927.18860.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

Am Freitag, 14. Oktober 2011, 09:14:11 schrieb Kukjin Kim:
> Heiko St?bner wrote:
[...]
> > Heiko Stuebner (8):
> >   S3C2416: Add armdiv_mask constant.
[...]
> As a note, if required, 1st patch which is fixing will be sent to stable.

I don't think this is really necessary.

The original code was essentially correct but hard to read.
The constant makes sense in the rework, as the armdiv_mask is is used in more 
places now and not contained in a single static function.

Heiko
