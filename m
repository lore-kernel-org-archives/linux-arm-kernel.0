From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 10:37:22 -0700
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140730133309.GF9809@8bytes.org>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730110425.GI12239@arm.com> <20140730132348.GM29590@ulmo>
 <20140730133309.GF9809@8bytes.org>
Message-ID: <CAOesGMgKzbGe0uZEH84i=uYttcweUaZfEeRgCU9dUd43T+pP2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 6:33 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Jul 30, 2014 at 03:23:50PM +0200, Thierry Reding wrote:
>> I think there weren't any comments left for me to address and I've
>> mostly been waiting for Joerg to pick it up.
>>
>> Joerg, can you take this through the iommu tree for 3.17? Will acked
>> this, but perhaps you were waiting for an ACK from the device tree
>> bindings maintainers?
>>
>> Will, perhaps you can get Pawel or Mark to look at this?
>>
>> Arnd, I'm sure if we had your Acked-by that would go a long way too.
>
> Yes, as Arnd requested this generic binding it would be good to have his
> Acked-by before proceeding. Arnd?

Arnd is on vacation now, unfortunately. I've read up on the history
and the current proposal from Thierry looks sane to me. As discussed,
there might be a need for some common helpers to walk the tree and
figure out things.

There's also the possibility that the IOMMU at init time actually
modifies and configures the stream IDs for the clients, but that again
is an implementation detail and not something that affects the binding
per se.

I'm not giving my Ack now since I want to make sure there are no
disagreements on my separate reply from a minute ago, but I expect
you'll have it once we've had that round trip of comments. :)


-Olof
