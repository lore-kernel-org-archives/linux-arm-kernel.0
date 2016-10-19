From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Oct 2016 20:25:23 -0700
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
References: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
Message-ID: <874m493tr0.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gottfried Haider <gottfried.haider@gmail.com> writes:

> Hi Eric, Linus,
>
> I'll hopefully find time to look at the more recent changes to the gpio
> subsystem (lsgpio?!), but since this patch is up for discussion now - what
> I was wondering: how does this change relate to /sys/class/gpio/gpio%d? Is
> this completely orthogonal - or would this change the sysfs interface as
> well?
>
> Regarding the proposed format using the header pin numbers: From what I've
> seen in terms of existing educational materials, it seems the overwhelming
> majority ends up using GPIO numbers instead of physical pin header
> numbering. (e.g. [1] [2])
> Would it be too confusing to try to pick GPIO 5 from an alphabetically
> sorted list like this "P11_GPIO17", "P12_GPIO18"? (I know, alphabetical
> sorting is an issue here already for a different reason. But applications
> might do it, I guess?)

I added the pin numbers because it was a consistent response to the
first version.  I do think the GPIO numbers without pin numbers would be
the most clear.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161018/cae67ff7/attachment.sig>
