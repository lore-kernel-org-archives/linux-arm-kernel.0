From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Oct 2011 16:44:03 +0900
Subject: [PATCH 0/8] S3C2416: Enable armdiv and armclk
In-Reply-To: <201110140927.18860.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
	<085f01cc8a40$df7af8a0$9e70e9e0$%kim@samsung.com>
	<201110140927.18860.heiko@sntech.de>
Message-ID: <087201cc8a45$0b901430$22b03c90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Hi Kgene,
> 
> Am Freitag, 14. Oktober 2011, 09:14:11 schrieb Kukjin Kim:
> > Heiko St?bner wrote:
> [...]
> > > Heiko Stuebner (8):
> > >   S3C2416: Add armdiv_mask constant.
> [...]
> > As a note, if required, 1st patch which is fixing will be sent to
stable.
> 
> I don't think this is really necessary.
> 
> The original code was essentially correct but hard to read.
> The constant makes sense in the rework, as the armdiv_mask is is used in
more
> places now and not contained in a single static function.
> 

OK.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
