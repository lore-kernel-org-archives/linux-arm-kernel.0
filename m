From: yalin.wang2010@gmail.com (yalin wang)
Date: Wed, 14 Oct 2015 20:01:06 +0800
Subject: [RFC] arm64: ioremap: add ioremap_cache macro
In-Reply-To: <5136228.H5nKeesgmE@wuerfel>
References: <1444616898-5057-1-git-send-email-yalin.wang2010@gmail.com>
 <20151013152011.GE11573@e104818-lin.cambridge.arm.com>
 <2731BCF2-D0C0-4B77-A59F-FF3AB2A725D6@gmail.com> <5136228.H5nKeesgmE@wuerfel>
Message-ID: <05C9B1A1-91F1-48C2-A6BC-CCB1585A2B77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Oct 14, 2015, at 16:23, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Wednesday 14 October 2015 10:41:26 yalin wang wrote:
> 
>>> On Oct 13, 2015, at 23:20, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>> I'm not sure we want this. See:
>>>> 
>>>> https://lkml.org/lkml/2015/10/9/699
>>> 
>>> Thanks Will and Arnd, I missed this. Patch reverted.
>>> 
>> i don?t understand why conflict with Dan Williams? patch.
>> Dan Williams ?s patch also define ioremap_cache  for arch ia64  & arch sh & arch xtensa ,
>> i see this :
>> # git show   92281dee825f
>> am i miss something?
> 
> I meant the new series, see https://lkml.org/lkml/2015/10/9/716 for the
> patch that removes it again.
> 
> 	Arnd
Got it ,
Thanks :)
