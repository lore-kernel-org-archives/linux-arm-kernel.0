From: gotom@sanori.org (Masanori Goto)
Date: Fri, 23 Nov 2012 20:27:14 +0900
Subject: [PATCH 097/493] scsi: remove use of __devexit_p
In-Reply-To: <Pine.LNX.4.64.1211230000500.11581@axis700.grange>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
 <Pine.LNX.4.64.1211230000500.11581@axis700.grange>
Message-ID: <CALZLnaErqPjtqbH5SROWjs-iAngXNFFr-f41K_a=9Akp4Aaudg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/23 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> On Mon, 19 Nov 2012, Bill Pemberton wrote:
>
>> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
>> needed.
>
>>  drivers/scsi/tmscsim.c                    | 2 +-
>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: GOTO Masanori <gotom@debian.or.jp>

Regards,
-- gotom

>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
