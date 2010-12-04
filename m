From: tony@atomide.com (Tony Lindgren)
Date: Sat, 4 Dec 2010 13:25:54 -0800
Subject: [PATCH v8 00/11] OMAP: GPIO: Implement GPIO as platform device
In-Reply-To: <AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<20101201183357.GI17222@atomide.com>
	<87zkso4hu3.fsf@deeprootsystems.com>
	<AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
Message-ID: <20101204212554.GM17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Varadarajan, Charulatha <charu@ti.com> [101202 06:08]:
> On Thu, Dec 2, 2010 at 15:28, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> 
> >
> > Tony, you can also add
> >
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

OK, updated. Also made one more GPIO patch to allow us to deal
with the 7xx vs 15xx/16xx MPUIO registers.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap-gpio-mpuio-regs.patch
Type: text/x-diff
Size: 7601 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101204/a1d1370d/attachment.bin>
