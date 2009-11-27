From: Thomas.Kunze@gmx.com (Thomas Kunze)
Date: Fri, 27 Nov 2009 21:44:36 +0100
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <20091125221113.GJ5136@n2100.arm.linux.org.uk>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>	<20091024211026.GE16451@n2100.arm.linux.org.uk>	<20091025153603.GA24490@rainbow>
	<20091115173048.GA19609@rainbow>	<20091123203931.GI18142@n2100.arm.linux.org.uk>	<20091124212541.GA5751@rainbow>	<20091125165301.GC5136@n2100.arm.linux.org.uk>	<4B0D6DD5.6090403@gmx.com>
	<20091125221113.GJ5136@n2100.arm.linux.org.uk>
Message-ID: <4B103A34.8020308@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux schrieb:
> On Wed, Nov 25, 2009 at 06:48:05PM +0100, Thomas Kunze wrote:
>   
>> Russell King - ARM Linux schrieb:
>>     
>>> On Wed, Nov 25, 2009 at 12:25:41AM +0300, Dmitry Artamonow wrote:
>>>   
>>>       
>>>> Oh, and forgot to mention - your 'sa1100' branch is currently based on
>>>> 2.6.32-rc3, you'll need to rebase it on more current -rc before applying
>>>> my patches, because of 4918a0139 (ARM: 5752/1: SA1100: fix building of
>>>> h3100), which went in -rc4.
>>>>     
>>>>         
>>> Ok, sa1100 rebased; please submit your patch series to the patch system,
>>> or alternatively if you have a git tree, base it off my sa1100 branch
>>> and I'll pull that instead.
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>   
>>>       
>> What about the collie patches? Should I do the same?
>>     
>
> Yes please.  I'd like to get all my outstanding branches sorted and
> merged into the 'devel' stuff so it can sit in linux-next for a while
> before the merge window.
>
>   
Please pull the for-lak branch at 
git://git.linuxtogo.org/home/thesing/collie.git
It contains the collie patches on top of 2.6.32-rc8 (see 
http://git.linuxtogo.org/?p=thesing/collie.git;a=shortlog;h=refs/heads/for-lak)

Regards,
Thomas
