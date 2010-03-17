From: hemanthv@ti.com (Hemanth V)
Date: Wed, 17 Mar 2010 20:10:15 +0530
Subject: Highmem issues with MMC filesystem
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
Message-ID: <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


----- Original Message ----- 
From: "Nicolas Pitre" <nico@fluxnic.net>
To: "Hemanth V" <hemanthv@ti.com>
Cc: <linux-mmc@vger.kernel.org>; <pierre@ossman.eu>
Sent: Wednesday, March 17, 2010 7:19 PM
Subject: Re: Highmem issues with MMC filesystem


> On Wed, 17 Mar 2010, Hemanth V wrote:
>
>> Hi All,
>>
>> We are trying to enable highmem support for OMAP based boards, while 
>> doing so
>> we are
>> unable to boot poky UI if the filesystem is in a MMC card.
>>
>> The poky UI comes up fine if the filesystem is in NAND or NFS,
>> while with MMC it gives errors like segmentation faults/syntax error 
>> while
>> there are none.
>> Seems like read from MMC is getting corrupted.
>
> Yes, this is a known issue with highmem on ARM architectures v6 and
> later, related to some cache mishandling.  This is not a MMC issue as
> the problem occurs when booting from SATA too. The problem is still
> investigated.
>

Nicolas, Russel are there any more details available which might help
in investigating this further.

Thanks
Hemanth

>
> Nicolas
> 
