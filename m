From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 7 May 2010 11:37:58 -0500
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
In-Reply-To: <1273212069.2178.9.camel@localhost>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020893C9@mi8nycmail19.Mi8.com>
	<1262799737.3181.8388.camel@macbook.infradead.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020893D4@mi8nycmail19.Mi8.com>
	<0D753D10438DA54287A00B0270842697636ECB4D36@AUSP01VMBX24.collaborationhost.net>
	<1273212069.2178.9.camel@localhost>
Message-ID: <0D753D10438DA54287A00B0270842697636ED546A3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 06, 2010 11:01 PM, Artem Bityutskiy wrote:
> On Thu, 2010-05-06 at 11:47 -0500, H Hartley Sweeten wrote:
>> Hello David,
>> 
>> Do you know the status of these two patches in linux-next:
>
> I'm not David, but I think I know the answer. Last merge window was
> missed and the mtd tree was not merged, so the patches are waiting for
> the next merge window and will be merged.

Hello Artem,

Ah, thought that was the issue.  It did appear that the mtd tree didn't
get merged.

> [snip]

>> I have some pending patches for arch/arm/mach-ep93xx/ts72xx.c that
>> depend on these.
>
> Just send your depending patches.

I'll hold until this gets merged (or dropped if that happens).

The patches are intended for the arm tree and I want to avoid any
merge issues.

Thanks for the update,
Hartley
