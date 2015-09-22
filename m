From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Sep 2015 11:45:40 +0100
Subject: [PATCH] arm: wire up userfaultfd and membarrier syscalls
In-Reply-To: <20150921171715.GR21084@n2100.arm.linux.org.uk>
References: <1442854833-10592-1-git-send-email-andre.przywara@arm.com>
 <20150921171715.GR21084@n2100.arm.linux.org.uk>
Message-ID: <56013154.1010401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 21/09/15 18:17, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2015 at 06:00:33PM +0100, Andre Przywara wrote:
>> Add the syscall numbers to the ARM syscall table. Both have
>> been briefly tested using the provided selftests from the tools
>> directory.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Hi Russell,
>>
>> I saw that Thierry sent something similar beginning of August already
>> (which is now outdated), is there any issue with enabling syscalls?
> 
> The only issue there is is that this was mentioned last week, and I
> replied about it last week.

I missed that because I only looked in the ARM kernel ML, sorry about that.

> I already have a patch pending for it, but I've been unable to merge
> it into mainline as my tree became somewhat messy due to the fixes
> missing -rc1 - which meant that my fixes branch was not recent enough
> to take that patch.  Now that those fixes are in, I can now start
> sorting my tree out, as I'd normally do after -rc1.

Fair enough and sorry for the noise.

Cheers,
Andre
