From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 26 Mar 2010 18:28:13 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <20100323101540.GB2049@bluebox.local>
References: <20100322191900.GF2040@bluebox.local>
	<20100322192748.GK2040@bluebox.local>
	<63386a3d1003230029r7ed7c4adm107298686aa14d5e@mail.gmail.com>
	<20100323101540.GB2049@bluebox.local>
Message-ID: <63386a3d1003261028rc9c24a2pb258a823118813cf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/23 Hans J. Koch <hjk@linutronix.de>:
> On Tue, Mar 23, 2010 at 08:29:01AM +0100, Linus Walleij wrote:
>> 2010/3/22 Hans J. Koch <hjk@linutronix.de>:
>> Also check that the DTCM is really such a thing.
>
> Yep, I'll do this.

If you really have a system with *only* DTCM and no ITCM, I don't
know if the TCM support in the kernel works with that right now,
I've never seen a system with just ITCM or just DTCM, but if
you can help me testing I will try to fix it up.

Linus
