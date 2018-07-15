From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jul 2018 20:36:46 +0200
Subject: [PATCH v4 2/5] dt-bindings: clock: Add S700 support for Actions
 Semi Soc's
In-Reply-To: <20180715143849.GC9980@Mani-XPS-13-9360>
References: <20180715123145.16975-1-sravanhome@gmail.com>
 <20180715123145.16975-3-sravanhome@gmail.com>
 <20180715143849.GC9980@Mani-XPS-13-9360>
Message-ID: <0d52c569-bd9a-2a17-c1ef-13e0d1fe4495@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 15.07.2018 um 16:38 schrieb Manivannan Sadhasivam:
> On Sun, Jul 15, 2018 at 02:31:42PM +0200, Saravanan Sekar wrote:
>> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
>> new file mode 100644
>> index 000000000000..905808bf335b
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/actions,s700-cmu.h
>> @@ -0,0 +1,118 @@
>> +/* SPDX-License-Identifier: GPL-2.0+

"GPL-2.0-or-later OR MIT" please for bindings and DT.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
