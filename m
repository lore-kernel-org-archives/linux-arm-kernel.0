From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 12:03:19 +0200
Subject: [PATCH] arm64: dts: marvell: mark the cp110 crypto engine as dma
 coherent
In-Reply-To: <20170718095130.GC2563@kwain> (Antoine Tenart's message of "Tue,
 18 Jul 2017 11:51:30 +0200")
References: <20170717073516.26746-1-antoine.tenart@free-electrons.com>
 <87o9si84ej.fsf@free-electrons.com> <20170718095130.GC2563@kwain>
Message-ID: <87bmoi83ko.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mar., juil. 18 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Hi Gregory,
>
> On Tue, Jul 18, 2017 at 11:45:24AM +0200, Gregory CLEMENT wrote:
>>  On lun., juil. 17 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
>> 
>> > The crypto engines found on the cp110 master and slave are dma coherent.
>> > This patch adds the relevant property to their dt nodes.
>> 
>> Is it a fix?
>> 
>> Should it go to the current ans stable kernel?
>
> Yes I think that should go into stable. I forgot the stable tag, do you
> want me to send a v2 with it included?
>
Yes please and also add the Fixes tag.

Thanks,

Gregory

> Thanks!
> Antoine

>
> -- 
> Antoine T?nart, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
