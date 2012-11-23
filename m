From: gotom@sanori.org (Masanori Goto)
Date: Fri, 23 Nov 2012 20:27:42 +0900
Subject: [PATCH 425/493] scsi: remove use of __devexit
In-Reply-To: <Pine.LNX.4.64.1211230845540.14984@axis700.grange>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-425-git-send-email-wfp5p@virginia.edu>
 <Pine.LNX.4.64.1211230845540.14984@axis700.grange>
Message-ID: <CALZLnaFcLwhNnvr5Hpia7tJkyJYmH-aj5GfHJxF8OS=uDkxoFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/23 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> On Mon, 19 Nov 2012, Bill Pemberton wrote:
>
>> CONFIG_HOTPLUG is going away as an option so __devexit is no
>> longer needed.
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
