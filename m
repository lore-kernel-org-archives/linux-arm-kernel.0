From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 29 Aug 2013 09:26:21 +0300
Subject: [GIT PULL] OMAPDSS: use new display drivers
In-Reply-To: <20130829061923.GM7656@atomide.com>
References: <521DAC2B.4080100@ti.com> <20130829061923.GM7656@atomide.com>
Message-ID: <521EE98D.9070209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/13 09:19, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 00:59]:
>> Hi,
>>
>> Here's a pull request for the board file changes to take the new display
>> drivers into use.
> 
> OK great.
>  
>> If there's an "early" pull request going to Linus during the merge window, it'd
>> be nice to have these in that request. That would give me time to send a pull
>> request to Linus containing removal of the old, no longer used, drivers.
> 
> Nice to see that this is not conflicting with anything in linux next :)

Did you add the series to your for-next branch?

> I suggest you keep this branch immutable in case it need to be merged to arm-soc
> tree, and merge it yourself along with the DSS patches. That way you

I do feel a bit uneasy with merging lots of arch changes via fbdev tree,
but yes, I guess I can do that. Is that an "ack" from you for all the
patches? If I do merge it via fbdev, I want to have at least acked-by in
the commits. If that was an ack, I'll add them, but it means I need to
update the branch.

> don't have a dependency to arm-soc for removal of the old drivers.

The dependency is run-time dependency, so the removal series does not
need to be based on this. As long as this series is merged first, things
should work.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/0cc4166d/attachment-0001.sig>
