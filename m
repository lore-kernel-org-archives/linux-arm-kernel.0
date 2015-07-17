From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jul 2015 17:13:36 +0800
Subject: [PATCH 3/6] clk: sunxi: Add A33 clock for compilation
In-Reply-To: <20150717090958.GM28632@lukather>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
 <1431240383-12763-4-git-send-email-vishnupatekar0510@gmail.com>
 <20150510101750.GC11057@lukather>
 <CAEzqOZv5pDPJgBfvNKk7vZuTr5H9hLdEOweyxStRFtarNxtFhQ@mail.gmail.com>
 <CAGb2v67NjfNjS_FQoYmEs2=OhKYRszgzuqiNPyww3UtiWCq--Q@mail.gmail.com>
 <20150717090958.GM28632@lukather>
Message-ID: <CAGb2v659_zRJ70Ee573s-V1-nAfuaiEY2VcYBKH6gUijqGhuPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 5:09 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Jul 17, 2015 at 04:57:11PM +0800, Chen-Yu Tsai wrote:
>> Hi Vishnu,
>>
>> This patch did not make v4.2-rc1.
>>
>> A33 support requires this patch. Otherwise the clock tree
>> is absent and nothing works.
>
> It got delayed and is in v4.2-rc2.

Ah, it's in the A33 machine support patch.
Not where I was expecting it.

Thanks.

ChenYu
