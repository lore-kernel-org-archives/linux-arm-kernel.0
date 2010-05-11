From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 10 May 2010 19:24:24 -0500
Subject: [PATCH v6 2/2] ep93xx: SPI driver platform support code
In-Reply-To: <20100505142625.GB2606@n2100.arm.linux.org.uk>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<865b5d7ca0fae1977a1fadcdabdb715e3ea1604d.1272805161.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636EB838E1@AUSP01VMBX24.collaborationhost.net>
	<20100505142625.GB2606@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B0270842697636EE74B65@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 05, 2010 7:26 AM, Russell King wrote:
> On Tue, May 04, 2010 at 12:21:36PM -0500, H Hartley Sweeten wrote:
>> That patch is already present in linux-next.  If Russell think there might
>> be an issue you could rebase this patch on the linux-next tree.
>
> If this patch depends on 5998/1, then I'll take it via the ep93xx branch
> (which has 5998/1 on.)  It's only touching files in arch/arm so there
> shouldn't be any problem with that.


Mika,

Any word from the spi group on PATCH v6 1/2?

Russell wants this patch (v6 2/2) to go through his tree, please add it to
his patch system.  It will not be a problem if this patch goes in before the
actual driver since nothing "breaks".  If the driver goes in first it will
not work due to the missing clock resource, even if a user were to hack in the
platform init code.

Regards,
Hartley
