From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Oct 2014 14:06:54 +0200
Subject: [PATCH v2 0/6] UIO driver for APM X-Gene QMTM
In-Reply-To: <CAPTm99V-xyXa7WQG2jzDz19gotJ0aQRPk_rb5ukvUpdFyFabfw@mail.gmail.com>
References: <1412051169-9142-1-git-send-email-ankit.jindal@linaro.org>
 <CAPTm99V-xyXa7WQG2jzDz19gotJ0aQRPk_rb5ukvUpdFyFabfw@mail.gmail.com>
Message-ID: <2114579.IN6EpqPdMv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 14:14:33 Ankit Jindal wrote:
> On 30 September 2014 09:56, Ankit Jindal <ankit.jindal@linaro.org> wrote:
> > This patchset enables user space access to APM X-Gene QMTM
> > using UIO framework.
> >
> > The patchset also introduces new type UIO_MEM_PHYS_CACHE
> > for mem regions because APM X-Gene QMTM device supports
> > cache coherency with CPU caches.
> 

I haven't been able to review the patch in detail yet, but I have
a very high-level question: how do you decide which driver to use?

I understand that the normal use case is for the QMTM to be used by
the kernel directly rather than being exported to user space, and
that the network driver will just use it if it is there.

	Arnd
