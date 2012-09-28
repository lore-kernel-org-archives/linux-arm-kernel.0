From: gerg@snapgear.com (Greg Ungerer)
Date: Fri, 28 Sep 2012 16:46:15 +1000
Subject: [PATCH] ARM: add back in KS8695 based SnapGear board entries
In-Reply-To: <CAOesGMhSvxGaKfM7uUm9v1CAHzYi_4XhJPaiYeBm7ZeuXnx=4Q@mail.gmail.com>
References: <1347247815-6751-1-git-send-email-gerg@snapgear.com>
 <20120910084259.GQ13739@n2100.arm.linux.org.uk>
 <CAOesGMhSvxGaKfM7uUm9v1CAHzYi_4XhJPaiYeBm7ZeuXnx=4Q@mail.gmail.com>
Message-ID: <506547B7.6090008@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...

On 13/09/12 16:52, Olof Johansson wrote:
> Hi,
>
> On Mon, Sep 10, 2012 at 1:42 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Sep 10, 2012 at 01:30:15PM +1000, gerg at snapgear.com wrote:
>>> From: Greg Ungerer <gerg@uclinux.org>
>>>
>>> Board support code for the SnapGear boards based on the Micrel KS8695 SoC
>>> will soon appear in mainline kernel. The board IDs had been removed from
>>> the mach-types file, so add them back in.
>>
>> Nak.  You must add platform support for these numbers _along_ _side_
>> adding them back to mach-types, otherwise my scripts will simply delete
>> them again.  These entries have been aged out due to lack of merging of
>> the platforms.
>
> Greg has submitted the new platforms for arm-soc but building of them
> will be broken until this update goes in.
>
> I guess we have the option of picking up the platform patch but not
> enabling it in the ks8695 defconfig until it's buildable (or enable it
> and have build breakage, which isn't awesome). Or, if you're OK with
> it (and give us an acked-by) we can include the mach-types patch in
> the same branch where the platform support gets merged.
>
> Russell, do you have a preference?
>
>
> -Olof
>
  
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
