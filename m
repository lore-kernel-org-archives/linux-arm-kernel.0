From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 30 Nov 2017 09:18:11 +0100
Subject: [PATCH] rtc: add mxc driver for i.MX53
In-Reply-To: <20171129221114.GV21126@piout.net>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
Message-ID: <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 11:11 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 28/11/2017 at 08:39:27 +0100, linux-kernel-dev at beckhoff.com wrote:
>> From: Patrick Bruenn <p.bruenn@beckhoff.com>
[]
>> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
>> new file mode 100644
>> index 000000000000..5049b521b38e
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-mxc_v2.c
>> @@ -0,0 +1,531 @@
>
> I think SPDX identifier will soon be required on new files, please add
> one.
>
>> +/*
>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + */
>> +
>> +/*
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */

Exactly!
And while you are it , you could replace the boilerplate license text
with the SPDX id.
-- 
Cordially
Philippe Ombredanne
