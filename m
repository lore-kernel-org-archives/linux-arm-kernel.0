From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Mar 2016 09:16:04 +0100
Subject: [PATCH 1/4] arm64: dts: marvell: Clean up armada-3720-db
In-Reply-To: <56F419CA.9010400@suse.de> ("Andreas =?utf-8?Q?F=C3=A4rber=22?=
 =?utf-8?Q?'s?= message of "Thu, 24 Mar 2016 17:46:02 +0100")
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-2-git-send-email-afaerber@suse.de>
 <87zitnn9ds.fsf@free-electrons.com> <56F419CA.9010400@suse.de>
Message-ID: <87oaa3m0qj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,
 
 On jeu., mars 24 2016, Andreas F?rber <afaerber@suse.de> wrote:

> Hi Gregory,
>
> Am 24.03.2016 um 17:11 schrieb Gregory CLEMENT:
>>> +/*
>>> + * Exported on the micro USB connector CON32
>>> + * through an FTDI
>>> + */
>> 
>> As the comment didn't start anymore from the middle of the line, we
>> could have it an a single line. We don't have to split in 2 lines.
>
> Sure. Should I change that along with 4/4 in a v2? It'll be after the
> Easter holidays.

Yes please and no problem for wiating for after the Easter holidays I
won't apply the patch on the mvebu branches before the release of the
v4.6-rc1.

Thanks,

Gregory

>
> Regards,
> Andreas
>
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
