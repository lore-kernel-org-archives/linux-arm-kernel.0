From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 16 Jul 2015 19:19:30 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
Message-ID: <20150716171930.GB27060@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 09:50:44AM +0200, Linus Walleij wrote:
> NACK. And it has been NACKed before again and again, search
> the mailinglist for repetitive answers.

Yeah, ok, I give up.

This happens with every DT discussion that tries to make things
logical for the end user.

> The GPIO numbers inside the Linux kernel are Linux specific and
> have nothing to do with the hardware numbers. If they sometimes
> match it is a lucky coincidence.

Someone should tell the users that.

> The same goes for IRQ numbers
> in the kernel FWIW.

Isn't there a mapping interface for irq numbers?
 
> So this "binding" has nothing to do with describing the hardware,
> which device tree is for. If it ever comes to exist it needs to be
> a "linux-*" property. But I doubt it will.

How can you say that the GPIO numbers associated with the pins and
appearing in published data sheets (and used in every schematic) are
not part of the hardware?

Thanks,
Richard
