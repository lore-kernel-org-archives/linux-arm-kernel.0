From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 07 Sep 2016 12:51:31 -0700
Subject: [PATCH] clk: meson-gxbb: Export PWM related clocks for DT
In-Reply-To: <20160907005208.GS12510@codeaurora.org> (Stephen Boyd's message
 of "Tue, 6 Sep 2016 17:52:08 -0700")
References: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
 <20160907005208.GS12510@codeaurora.org>
Message-ID: <7ha8fjtrng.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 08/22, Neil Armstrong wrote:
>> Add the PWM related clocks in order to be referenced as PWM source
>> clocks.
>> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>
> With some more thought, it should go through whatever tree takes
> the dts changes. Conflicts in these header files should be
> managed by the same person and that person is the platform
> maintainer.

OK, I'll pick this up and take it through the amlogic -> arm-soc path.

Thanks,

Kevin
