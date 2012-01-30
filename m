From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 30 Jan 2012 11:08:19 +0100
Subject: ARM/ARM-SoC plans for v3.4 merge window
In-Reply-To: <CAOesGMh45HSb4mRMc7q53xhmj_kMFvdVJhNnY7cY6gHi=_KynQ@mail.gmail.com>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
 <20120124095009.GS16726@n2100.arm.linux.org.uk>
 <20120126212319.GE11941@n2100.arm.linux.org.uk>
 <CAOesGMh45HSb4mRMc7q53xhmj_kMFvdVJhNnY7cY6gHi=_KynQ@mail.gmail.com>
Message-ID: <4F266C13.5080302@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2012 12:57 AM, Olof Johansson :
> Hi,
> 
> 
> On Thu, Jan 26, 2012 at 1:23 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> 
>> And we're now there.  So...
>>
>> Arnd, Olaf,
>>
>> Please incorporate the latest ARM (for-armsoc branch) changes, which can be found at:
>>
>>        git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git for-armsoc
>>
>> with SHA1 dcf81c1af839b77b44404453ecae6e5ac5a75f05.
> 
> Thanks. I have added this as depends/rmk/for-armsoc in the arm-soc repo.
> 
> Any next/ branch we start will have this as the base of said branch,
> so any vendor branches must either already be developed against this
> stable branch, or merge on top of this with minimal conflicts.

Ok, great.

I just let you know that there is a conflict between the current Linus'
tree (with recently updated at91 fixes) and this rmk/for-armsoc branch.

I can give you the resolution of this conflict easily but I would like
to know which way I execute the merge:

I use this rmk/for-armsoc as a baseline and merge the fixes already in
Linus' tree on top of it or the other way around?

Maybe it is preferable that I wait for 3.3-rc2 and merge rmk/for-armsoc
on top of it. This result can be the base of our AT91 work for 3.4
preparation.

Your thought?

Best regards,
-- 
Nicolas Ferre
