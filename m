From: camhirundo@gmail.com (Hirundo Cam)
Date: Thu, 5 May 2011 08:11:01 +0800
Subject: [PATCH v2] kirkwood: add dir-665 support
In-Reply-To: <20110504081627.GY19806@kw.sim.vm.gnt>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<1304496346-13557-1-git-send-email-camhirundo@gmail.com>
	<20110504081627.GY19806@kw.sim.vm.gnt>
Message-ID: <BANLkTi=Tmqhq2q9Qs_5kNEZ5229ePJ2Cuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

2011/5/4 Simon Guinot <simon@sequanux.org>:
> Hi Hirundo,
>
> On Wed, May 04, 2011 at 04:05:46PM +0800, Hirundo Cam wrote:
>> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
>> LEDs, GPIO, Buttons remains unknown.
>>
>> To use this patch, on board u-boot must also be recompiled and replaced.
>
> Just for curiosity, what is the problem the stock U-Boot ?
>
> Regards,
>

Just as Jean-Christophe said,
I guess the mach-type id in origin u-boot which shipped with the
DIR-665 is differed.
Hence the u-boot must update to the new mach-type ID.

It is hard to find out which the origin mach-type has been used. I'm
not sure if hexdump
could help.

Anyway, I just replaced the u-boot and get it boot luckly.

Regards,
Hirundo Cam
