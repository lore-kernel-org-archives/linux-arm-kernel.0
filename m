From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 Dec 2009 01:40:24 -0500
Subject: [patch 1/4] [ARM] mmp: support PJ4 core
In-Reply-To: <f17812d70912062227t23daeddbj65fcda4053af9c39@mail.gmail.com>
References: <771cded00912062218w1296d9eem32ead5466b675838@mail.gmail.com>
	<f17812d70912062226n1456e768j41bcefa07f3e9f7e@mail.gmail.com>
	<f17812d70912062227t23daeddbj65fcda4053af9c39@mail.gmail.com>
Message-ID: <771cded00912062240r7a6119am16026c1f85ba482@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2009 at 1:27 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Loop in Saeed and Nico.
>
> On Mon, Dec 7, 2009 at 2:26 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Mon, Dec 7, 2009 at 2:18 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>>> From e4abbf0b65f7581867bbca492741fe5617bc346d Mon Sep 17 00:00:00 2001
>>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> Date: Fri, 4 Dec 2009 08:35:17 -0500
>>> Subject: [PATCH] [ARM] mmp: support PJ4 core
>>>
>>> Marvell PJ4 core is compatible to ARMv6 architecture.
>>>
>>
>> Haojian,
>>
>> Please take a look into Saeed's dove support patches submitted days ago.
>>
>> http://www.spinics.net/lists/arm-kernel/msg78076.html.
>>
>> Which may render this patch unnecessary.
>>
>
Hi Eric,

Yes, the first patch is reproduced of saeed's. Since we're both using
PJ4 core. So I formated it into one patch. If saeed's patch is merged,
my first patch can be dropped directly.

Thanks
Haojian
