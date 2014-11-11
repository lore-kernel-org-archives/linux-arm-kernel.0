From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Nov 2014 00:53:07 +0800
Subject: [PATCH resend 0/4] clk: sunxi: Unify sun4i apb1 clock
In-Reply-To: <20141111145519.GI14919@lukather>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <20141111145519.GI14919@lukather>
Message-ID: <CAGb2v679z_9xt4kbpegodbBTKJTKAq2Ygz7J22as0D9QsHEc=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 10:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Nov 06, 2014 at 11:40:28AM +0800, Chen-Yu Tsai wrote:
>> (resent with linux-arm-kernel CCed)
>>
>> Hi everyone,
>>
>> This series unifies the apb1 clock driver for sun4i, which was
>> previously split into apb1-mux and apb1. This also fixes the
>> apb2 clock on sun6i/sun8i, which we now have documents for.
>>
>> The first 2 patches were done by Emilio.
>>
>> Patch 1 unifies the apb1-mux and apb1 clock drivers using a
>> factors clock.
>>
>> Patch 2 unifies said clocks in the dtsi.
>>
>> Patch 3 switches the compatibles for apb2 clock on sun6i/sun8i to
>> the unified sun4i apb1 clock.
>>
>> Patch 4 gets rid of the incorrect and now unused sun6i apb2 clock
>> driver.
>
> Merged all the patches, thanks!

Thanks! I'll send out sun6i ahb1 unification v3 later.

ChenYu
