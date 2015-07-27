From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 27 Jul 2015 14:26:28 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdYUcXjJz+jZ5ZMXK1a7GLi8eL+ecr-yL6Y8901f_-pknQ@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>	<d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>	<CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>	<20150716171930.GB27060@localhost.localdomain>
 <CACRpkdYUcXjJz+jZ5ZMXK1a7GLi8eL+ecr-yL6Y8901f_-pknQ@mail.gmail.com>
Message-ID: <55B62374.1030004@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 12:19 PM, Linus Walleij wrote:
> I don't see what you mean here. The numbers that appear in
> say /proc/interrupts may seem stable but they are not.
> They depend on things like probe order between irqchips
> and can change between two boots.

Not only on DT platforms but also on X86 where one has MSI interrupts
which are allocated on probe time of the driver for a PCI device.

> Yours,
> Linus Walleij

Sebastian
