From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 29 Aug 2013 22:00:16 +0100
Subject: [PATCH v3 4/6] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
In-Reply-To: <20130828090354.GP2695@lukather>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-5-git-send-email-josh.wu@atmel.com>
 <20130828090354.GP2695@lukather>
Message-ID: <521FB660.8010607@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/13 10:03, Maxime Ripard wrote:
> Hi Josh,
> 
> On Tue, Aug 27, 2013 at 07:28:50PM +0800, Josh Wu wrote:
>> Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed. This patch can choose different
>> start up time calculation formula for different chips.
>> 
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
Unfortunately this one has a dependency on the fix patch which is going in through
my fixes branch so will have to wait until that hits my upstream.

I'd like 5 and 6 to sit a while longer anyway (and 6 needs Dmitry's sign off before
I take that.)

Thanks for these,

Jonathan
