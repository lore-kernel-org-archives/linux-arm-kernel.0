From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 17:46:02 +0100
Subject: [PATCH 1/4] arm64: dts: marvell: Clean up armada-3720-db
In-Reply-To: <87zitnn9ds.fsf@free-electrons.com>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-2-git-send-email-afaerber@suse.de>
 <87zitnn9ds.fsf@free-electrons.com>
Message-ID: <56F419CA.9010400@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Am 24.03.2016 um 17:11 schrieb Gregory CLEMENT:
>> +/*
>> + * Exported on the micro USB connector CON32
>> + * through an FTDI
>> + */
> 
> As the comment didn't start anymore from the middle of the line, we
> could have it an a single line. We don't have to split in 2 lines.

Sure. Should I change that along with 4/4 in a v2? It'll be after the
Easter holidays.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
