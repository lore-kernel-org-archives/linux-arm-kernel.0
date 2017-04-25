From: icenowy@aosc.io (icenowy at aosc.io)
Date: Tue, 25 Apr 2017 13:47:55 +0800
Subject: [linux-sunxi] [PATCH v4 07/10] mfd: axp20x: add axp20x-regulator
 cell for AXP803
In-Reply-To: <CAGb2v673CL6TaZxkNR9SZDiG5G3cMqU1-=XeMj5gyDbQq4YzVA@mail.gmail.com>
References: <20170424160103.9447-1-icenowy@aosc.io>
 <20170424160103.9447-8-icenowy@aosc.io>
 <CAGb2v673CL6TaZxkNR9SZDiG5G3cMqU1-=XeMj5gyDbQq4YzVA@mail.gmail.com>
Message-ID: <135a9d075cdd4138db1a8937e5a1413f@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-04-25 10:17?Chen-Yu Tsai ???
> On Tue, Apr 25, 2017 at 12:01 AM, Icenowy Zheng <icenowy@aosc.io> 
> wrote:
>> As axp20x-regulator now supports AXP803, add a cell for it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>> Changes in v4:
>> - Added a trailing comma for new cell, for easier further cell 
>> addition.
>> Changes in v3:
>> - Make the new cell one-liner.
>> 
>>  drivers/mfd/axp20x.c                 | 3 ++-
>>  drivers/regulator/axp20x-regulator.c | 6 +++---
> 
> Squashed in wrong patch?

Oh seems so...

> 
> ChenYu
