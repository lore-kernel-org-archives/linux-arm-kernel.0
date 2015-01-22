From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Thu, 22 Jan 2015 22:54:42 +0200
Subject: [RFC] using dt overlays: how to? today?
In-Reply-To: <20150122150219.GB26928@odux.rfo.atmel.com>
References: <20150122150219.GB26928@odux.rfo.atmel.com>
Message-ID: <2F10D177-6F27-4019-8D2D-8F77361BB310@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

> On Jan 22, 2015, at 17:02 , Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> 
> Hi,
> 
> I have assisted to Pantelis' talk about device tree and overlays at ELCE
> 2014. Since the patch 'Introduce DT overlay support' is now part of the
> mainline, I wanted to have a look about it and to use it for our boards.
> 

Excellent.

> Firstly, this is what I want to achieve by using this feature:
> - manage several revisions of our boards
> - manage modules we can plug on the board, mainly display modules
>  (resistive or capacitive one)
> - manage cpu modules plug on the motherboard
> - I would like to have all this stuff in the kernel. I don't want a
>  dependency on the bootloader or the user space.
> 

That?s awesome; that?s exactly what I want to use it for. Maybe this thing
can be used by others as well ;)

> At the moment, we have many dts files to manage these cases (not all are
> in mainline). It is becoming a pain.
> 

Tell me about it.

> I wanted to see if we can use device tree fragments as it seems to be
> closed to be achieved when I had assisted to the talk. I have found a
> thread about 'DT-Overlay configfs interface'
> (http://thread.gmane.org/gmane.linux.drivers.devicetree/101871), there
> are still discussions about security concerns, so it may not be included
> quickly. I have also found an interesting thread about cape manager for
> Beaglebone (http://thread.gmane.org/gmane.linux.documentation/8279) but
> there is no more activity on it, is it canceled or is there a new topic
> I have missed?
> 
> Here are my questions:
> - Is it acceptable to manage device tree fragments with a driver such as
>  the cape manager? Or at an other place in the kernel such as
> arch/arm/mach-at91/board-dt-sama5.c for example?
> - Is it possible to get access to eeprom from the kernel? Pantelis did
>  an interface to access it through i2c but it seems it was not
> accepted. In my case, it will be through the one wire interface.
> 
> Thanks for sharing your opinion about this or redirecting me to a
> similar thread.
> 

I?m waiting for 3.19 to go out and I?ll address everything you described
above.

Feel free to post specific requirement about your use cases, and I?ll try
to address them.

> Ludovic
> ?

Regards

? Pantelis
