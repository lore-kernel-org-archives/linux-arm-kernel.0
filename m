From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 26 Aug 2015 10:17:05 -0700
Subject: [PATCH 5/5] MAINTAINERS: add entry for the Broadcom Northstar
 Plus SoCs
In-Reply-To: <CAOesGMioBQY9qy-S8kMJmo_=B6-KZiUkd=Ns1Uo2dGu0BiqppQ@mail.gmail.com>
References: <1440092861-25825-1-git-send-email-jonmason@broadcom.com>
 <CAOesGMioBQY9qy-S8kMJmo_=B6-KZiUkd=Ns1Uo2dGu0BiqppQ@mail.gmail.com>
Message-ID: <55DDF491.3090700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/15 16:42, Olof Johansson wrote:
> On Thu, Aug 20, 2015 at 10:47 AM, Jon Mason <jonmason@broadcom.com> wrote:
>> Modify the iProc MAINTAINER to cover the Nortstar Plus SoCs, and add me
>> to the list of people responsible for it.
> 
> That's not what this patch does. It removes CYGNUS from the
> description as well. Hmm?
> 
> I'm also not a fan of the complex patterns, but that's more of a
> bikeshedding comment. Does Broadcom really not have a bit more
> systematic naming than this? :)

The naming conventions are fairly simple actually:

* BCM is just a common prefix for internal names/projects/whatever
* 9 indicates that this is a development/reference board
* 4 to 5 digits designate the chip identifier

Now, if you are trying to get some sense about how the chip ids are
actually chosen, I am afraid none of us have that knowledge ;)

> 
>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> For maintainer updates, we usuallu like to see a public ack of this
> and not just a pre-acked patch. You _could_ have added it yourself
> without Scott's actual approval, after all.
> 
> 
> -Olof
> 


-- 
Florian
