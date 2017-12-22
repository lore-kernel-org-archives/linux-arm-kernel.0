From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 22 Dec 2017 11:47:42 +0100
Subject: [PATCH v2 4/5] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3C@BMK019S01.emtrion.local>
References: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3C@BMK019S01.emtrion.local>
Message-ID: <18403050-7b4c-ecae-75bd-b67d72d63eeb@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.12.2017 um 11:34 schrieb T?rk, Jan:
>> On Wed, Dec 20, 2017 at 02:47:04PM +0100, jan.tuerk at emtrion.com wrote:
>>> + * SPDX-License-Identifier: GPL-2.0
>>
>> You have this.
>>
>> Also, the rules around this are getting a bit stricter saying the SPDX
>> tag should be the first line of the file using a C++ style comment.
>>
> I'll change it for v3 of this patch however it will end up like this:
> //SPDX-License...

I would've expected:

// SPDX-License...
> /*
>  *  Copyright 

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
