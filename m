From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 21 Oct 2014 23:07:58 +0200
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <CAOesGMhSuvbWpM5CC_5Hy6BskM6sbrw0SCR90aKHvfk1Qm1_Ng@mail.gmail.com>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>	<CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>	<5446C775.3030707@suse.de>
 <CAOesGMhSuvbWpM5CC_5Hy6BskM6sbrw0SCR90aKHvfk1Qm1_Ng@mail.gmail.com>
Message-ID: <5446CB2E.4080503@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.10.2014 um 23:01 schrieb Olof Johansson:
> On Tue, Oct 21, 2014 at 1:52 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Am 18.10.2014 um 06:28 schrieb Olof Johansson:
>>> I did a test run with yesterday's -next It looks like networking isn't
>>> working there at the moment, clock related. Same happens with 3.17 and
>>> latest mainline, config multi_v7_defconfig:
>>>
>>> [WARN] [    7.943648] macb e000b000.ethernet eth0: unable to generate
>>> target frequency: 125000000 Hz
>>> [WARN] [   10.948681] macb e000b000.ethernet eth0: unable to generate
>>> target frequency: 125000000 Hz
>>
>> I am unable to reproduce this in my setup - at Linus' tip
>> c2661b806092d8ea2dccb7b02b65776555e0ee47 (v3.18-rc1-68-gc2661b8), make
>> oldconfig'ing my /proc/config.gz.
>>
>> S?ren, in light of your explanations, should I be expecting problems
>> with 1GbE or with 100MbE? My board is connected to a 1GbE switch.
> 
> My board might have old firmware/bitstream on it? It reports as:
> 
> U-Boot 2012.10-00003-g792c31c (Jan 03 2014 - 12:24:08)

Mine reports the same version.

sha512sum of non-headless bitstream:
decb37222a7da0de39b1c1eb95714500cc006506cc86d85ed9c6c7b30c7cd7b91ef3592b886311f4285b5ce0079b4ffcd83f91ae275435ac15cefefe7db00b08
 /mnt/parallella.bit.bin

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
