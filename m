From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 10 Sep 2012 22:02:01 +1000
Subject: [PATCH] ARM: add back in KS8695 based SnapGear board entries
In-Reply-To: <20120910084259.GQ13739@n2100.arm.linux.org.uk>
References: <1347247815-6751-1-git-send-email-gerg@snapgear.com>
 <20120910084259.GQ13739@n2100.arm.linux.org.uk>
Message-ID: <504DD6B9.9050803@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 06:42 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 10, 2012 at 01:30:15PM +1000, gerg at snapgear.com wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> Board support code for the SnapGear boards based on the Micrel KS8695 SoC
>> will soon appear in mainline kernel. The board IDs had been removed from
>> the mach-types file, so add them back in.
>
> Nak.  You must add platform support for these numbers _along_ _side_
> adding them back to mach-types, otherwise my scripts will simply delete
> them again.  These entries have been aged out due to lack of merging of
> the platforms.

So if I combine this with:

 
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118237.html

and submit as a single patch (through the arm-soc tree) will that cause
your scripts any problems?

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
