From: Grant.Likely@arm.com (Grant Likely)
Date: Thu, 6 Sep 2018 17:52:06 +0000
Subject: [PATCH] efi_stub: update documentation on dtb= parameter
In-Reply-To: <20180906095111.1a74dfcd@lwn.net>
References: <20180905190750.4566-1-grant.likely@arm.com>,
 <20180906095111.1a74dfcd@lwn.net>
Message-ID: <BFA61ADA-2AD9-4383-ADAA-9D660881865B@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 6 Sep 2018, at 16:51, Jonathan Corbet <corbet@lwn.net> wrote:
> 
> On Wed,  5 Sep 2018 20:07:50 +0100
> Grant Likely <grant.likely@arm.com> wrote:
> 
>> The dtb= parameter is no longer the primary mechanism for providing a
>> devicetree to the kernel. Now either firmware or the boot selector (ex.
>> Grub) should provide the devicetree and dtb= should only be used for
>> debug or when using firmware that doesn't understand DT.
>> Update the EFI stub documentation to reflect the current usage.
> 
> So I hate to be obnoxious, but...
> 
>> IMPORTANT NOTICE: The contents of this email and any attachments are
>> confidential and may also be privileged. If you are not the intended
>> recipient, please notify the sender immediately and do not disclose the
>> contents to any other person, use it for any purpose, or store or copy
>> the information in any medium. Thank you.
> 
> Can I get a version of the patch without this language?  Then I'll be glad
> to apply it.

Ugh. Well that was dumb. There is a magic trick I have to perform to get rid of the disclaimer, but it didn?t work this time. I?ll fix and get a new one out.

g.

> 
> Thanks,
> 
> jon
