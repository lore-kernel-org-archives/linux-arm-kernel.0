From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Sep 2016 11:12:19 -0700
Subject: [PATCH 3/7] clk: gxbb: expose spifc clock
In-Reply-To: <20160907212754.GB12510@codeaurora.org> (Stephen Boyd's message
 of "Wed, 7 Sep 2016 14:27:54 -0700")
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
 <1473261223-15412-4-git-send-email-jbrunet@baylibre.com>
 <20160907212754.GB12510@codeaurora.org>
Message-ID: <m24m5qntvg.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 09/07, Jerome Brunet wrote:
>> SPI clock is needed for the spifc driver, expose to DT
>> (and comment out in the clk driver)
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Applied,

Kevin
