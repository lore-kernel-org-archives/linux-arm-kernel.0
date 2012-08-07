From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 07 Aug 2012 19:06:37 +0900
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <CACRpkdZLGhgpUJy_3QGYvGRqyxMkkPPSdyP==h5YurWqKnctBw@mail.gmail.com>
References: <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
 <20120701104401.GA4352@mail.gnudd.com> <20120703130042.GA10007@mail.gnudd.com>
 <201207031319.40884.arnd@arndb.de>
 <20120703193403.GA26355@n2100.arm.linux.org.uk>
 <CACRpkdZLGhgpUJy_3QGYvGRqyxMkkPPSdyP==h5YurWqKnctBw@mail.gmail.com>
Message-ID: <098e01cd7484$553871c0$ffa95540$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 

[...]

> The major reason why that file is there is that there is *another*
> PL080 driver in arch/arm/mach-s3c64xx/dma.c which I repeatedly
> asked the Samsung people to replace with the
> drivers/dma/amba-pl08x.c driver. :-(
> 
> When I worked on the PL08x driver in drivers/dma I reused
> this header to avoid code duplication.
> 
> Now that thing is stranding in the way. Alim, Kukjin, what's happening?
> 
Afaik, Alim was working on that but I'm not sure how long he needs more?

Alim, please share the progress of the pl080 work?

> I feel tempted to update Alim's patch myself and push it on you
> soon...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
