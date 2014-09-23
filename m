From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 23 Sep 2014 09:40:12 +0200
Subject: [PATCH v12 00/10] Per-user clock constraints
In-Reply-To: <20140922150658.GM5182@n2100.arm.linux.org.uk>
References: <1411395124-2476-1-git-send-email-tomeu.vizoso@collabora.com>
 <20140922150658.GM5182@n2100.arm.linux.org.uk>
Message-ID: <542123DC.7060408@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2014 05:06 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 22, 2014 at 04:12:02PM +0200, Tomeu Vizoso wrote:
>> Hello,
>>
>> my branch was finally processed by the 0day build farm and I have fixed the
>> three issues that came up:
> 
> Patch 3 did not come through, so I can't see the changes there.

Yeah, I think all mailing lists choke on it because of its size and the
number of recipients, except linuxppc-dev:

http://patchwork.ozlabs.org/patch/391967/

You were on CC though.

> I'm
> assuming that there's some changes to clkdev in there which I need to
> see.

Nope, that one doesn't touch clkdev.

>> * export __clk_get and __clk_put, so they can be used by clock implementations
>> in modules that previously used clk_get and clk_put.
> 
> This is something I'm not happy about.  We don't want people getting
> access to these low level functions.

I see, will think something about it.

Thanks,

Tomeu
