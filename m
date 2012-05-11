From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 11 May 2012 09:10:42 -0600
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <201205092047.06852.arnd@arndb.de>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
 <201205092027.50059.arnd@arndb.de>
 <37e096905f891fc6abdccf8977bd7447@localhost>
 <201205092047.06852.arnd@arndb.de>
Message-ID: <CACxGe6u+4qZ=6qW8P8LPyQAABv4GS5TXvs+azfX7v--HVLqCBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 2:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 May 2012, Marc Zyngier wrote:
>> Ah, I see what you mean. But these registers and interrupt are actually
>> only visible on the hypervizor side. The guest shouldn't see any of this.
>
> Rihgt, that makes sense.
>
>> I suppose we could have a "arm,has-virt-extensions" property in devices
>> that implement the virtualization extensions (GIC, timers...).
>>
>> What do you think?
>
> Sounds good. I don't have a strong preference whether that should be a
> property like you suggest or a separate "compatible" value, maybe Rob or
> Grant can comment on what they prefer.

I don't have a strong opinion either way.  This approach looks fine.

g.
