From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Aug 2009 11:18:21 +0200
Subject: ARM Git Tree (at91sam9g45 patches)
In-Reply-To: <4A9488FB.60603@eukrea.com>
References: <9f53b4330908251727q1bc1accfk12a9a8d25407791@mail.gmail.com>
	<4A9488FB.60603@eukrea.com>
Message-ID: <4A94FDDD.205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric B?nard :
> Hi Robert,
> 
> Robert Emanuele wrote :
>> I'm working with the Atmel at91sam9g45-ekes board which is new.  I was
>> wondering if there was a git tree with the current ARM patches that
>> contains the at91sam9g45 code?  Russell lists "Applied" patches at
>> http://www.arm.linux.org.uk/developer/patches/ .  Where are these
>> applied to?  If there isn't a tree, is there an elegant way to get the
>> latest patch sets that I could apply to Linus's tree?
>>
> you will find the files that you can apply using git am here :
> ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/

Yes, devel branch contains 9g45 patches.

Another place where you can find quite all drivers that I submitted
during the past weeks is in the linux-next tree:

http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary

FYI, I am building a patchset collecting all those submitted patches
against 2.6.30 + Andrew Victor -at91 patch.
It is not finished at the moment but I can send it in private.

I am in contact with Ulf and others for OE and Buildroot inclusion.

This patchset will be available in linux4sam.org in a few weeks.

Best regards,
-- 
Nicolas Ferre
