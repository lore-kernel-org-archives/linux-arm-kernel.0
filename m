From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 10:12:41 -0800
Subject: [PATCH] clk: meson-gxbb: Export HDMI clocks
In-Reply-To: <20170117183441.GU17126@codeaurora.org> (Stephen Boyd's message
 of "Tue, 17 Jan 2017 10:34:41 -0800")
References: <1484654928-5640-1-git-send-email-narmstrong@baylibre.com>
 <20170117183441.GU17126@codeaurora.org>
Message-ID: <m2mveo1bl2.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 01/17, Neil Armstrong wrote:
>> Export HDMI clock from internal to dt-bindings.
>> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>
> I think we decided this would go with the dts changes if more
> needed to be exposed.

Ah, that's right.  I'll queue it up in the amlogic dt branch with your
ack.

Thanks,

Kevin
