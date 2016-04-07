From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 07 Apr 2016 12:00:51 -0700
Subject: [PATCH 1/4] arm64: dts: marvell: Clean up armada-3720-db
In-Reply-To: <87oaa3m0qj.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 25 Mar 2016 09:16:04 +0100")
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-2-git-send-email-afaerber@suse.de>
 <87zitnn9ds.fsf@free-electrons.com> <56F419CA.9010400@suse.de>
 <87oaa3m0qj.fsf@free-electrons.com>
Message-ID: <878u0pjlb0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,
 
 On ven., mars 25 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Andreas,
>  
>  On jeu., mars 24 2016, Andreas F?rber <afaerber@suse.de> wrote:
>
>> Hi Gregory,
>>
>> Am 24.03.2016 um 17:11 schrieb Gregory CLEMENT:
>>>> +/*
>>>> + * Exported on the micro USB connector CON32
>>>> + * through an FTDI
>>>> + */
>>> 
>>> As the comment didn't start anymore from the middle of the line, we
>>> could have it an a single line. We don't have to split in 2 lines.
>>
>> Sure. Should I change that along with 4/4 in a v2? It'll be after the
>> Easter holidays.
>
> Yes please and no problem for wiating for after the Easter holidays I
> won't apply the patch on the mvebu branches before the release of the
> v4.6-rc1.

Do you think you could send a v2 of the serie soon?

I would like to have it in the mvebu/dt64 tree as it will impact all the
next patches aimed for these files.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
