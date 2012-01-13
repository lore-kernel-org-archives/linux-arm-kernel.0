From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 13 Jan 2012 11:35:13 +0100
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
In-Reply-To: <20120112210055.GD16726@n2100.arm.linux.org.uk>
References: <20120112184256.GA2287@atomide.com>
 <20120112200443.GA16726@n2100.arm.linux.org.uk>
 <20120112201112.GB16726@n2100.arm.linux.org.uk>
 <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
 <20120112202712.GC16726@n2100.arm.linux.org.uk>
 <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
 <20120112210055.GD16726@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gzMnXgTAM7V1ZOvgtX5CoDXywc2-hKj+BqUWg5EDH4YdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 10:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 12, 2012 at 09:32:40PM +0100, Shilimkar, Santosh wrote:
>> OK. Point taken.
>
> Can you also explain this in the code:
>
> ? ? ? ?size = ALIGN(PAGE_SIZE, SZ_1M);
>
> Isn't that just SZ_1M written in a rather complex way? ?A comment may be
> a better way of explaining it.

memblock alloc was failing without the alignment IIRC. Will add comments
about the same.

Regards
Santosh
