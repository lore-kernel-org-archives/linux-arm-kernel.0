From: P.Bruenn@beckhoff.com (=?utf-8?B?UGF0cmljayBCcsO8bm4=?=)
Date: Thu, 30 Nov 2017 14:24:22 +0000
Subject: [PATCH] rtc: add mxc driver for i.MX53
In-Reply-To: <CAOFm3uHAXKr7KiFeyvYb77jot8M_4rH-cqt2Ze3AbnOiZ_wiwg@mail.gmail.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
 <CAOFm3uHAXKr7KiFeyvYb77jot8M_4rH-cqt2Ze3AbnOiZ_wiwg@mail.gmail.com>
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531375@NT-Mail07.beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
>Sent: Donnerstag, 30. November 2017 15:00
>On Thu, Nov 30, 2017 at 2:36 PM, Patrick Br?nn <P.Bruenn@beckhoff.com>
>wrote:
>
>Thomas:
>I tend to prefer as Linus pointed the // style throughout when there
>is only a license and copyright involved. Here this would mean:
>
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2004-2011 Freescale Semiconductor, Inc. All Rights
>Reserved.
>
>What's you take since you wrote the doc for this? And is there still
>some updates needed for this since your last patch set?
>
While looking closer into different files I think it would become multiline again:
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock (RTC) Driver for i.MX53
+ * Copyright (c) 2004-2011 Freescale Semiconductor, Inc.
+ * Copyright (c) 2017 Beckhoff Automation GmbH & Co. KG
+ */

>
>Patrick:
>Side note a trailing  "All Rights Reserved." in a copyright statement
>is never needed, even though customarily cargo culted by everyone,
>including me.
>Started in 1910, it become fully obsolete in 2000 thanks to Nicaragua
>[1] signing the Berne convention.
>
>[1] https://en.wikipedia.org/wiki/All_rights_reserved
Interessting. I just kept it because it was in the original file from freescale.
But with this background, I think it's fine to drop it, now.

Thanks,
Patrick
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
