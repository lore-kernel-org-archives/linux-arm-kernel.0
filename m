From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 21:00:55 +0000
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
In-Reply-To: <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
References: <20120112184256.GA2287@atomide.com>
 <20120112200443.GA16726@n2100.arm.linux.org.uk>
 <20120112201112.GB16726@n2100.arm.linux.org.uk>
 <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
 <20120112202712.GC16726@n2100.arm.linux.org.uk>
 <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
Message-ID: <20120112210055.GD16726@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 09:32:40PM +0100, Shilimkar, Santosh wrote:
> OK. Point taken.

Can you also explain this in the code:

	size = ALIGN(PAGE_SIZE, SZ_1M);

Isn't that just SZ_1M written in a rather complex way?  A comment may be
a better way of explaining it.
