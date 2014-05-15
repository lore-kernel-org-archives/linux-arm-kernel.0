From: nm@ti.com (Nishanth Menon)
Date: Thu, 15 May 2014 07:14:30 -0500
Subject: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
In-Reply-To: <20140515074724.GJ16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140515074724.GJ16662@pengutronix.de>
Message-ID: <CAGo_u6pxat1=X5tvqb8FYqUttYTaAimbjcdwsUYtS-rYt59v+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 2:47 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
>> cpufreq, which simply divides values it obtains through clk_round_rate() by
>> 1000, 666666.
>> Since passing 666666 to clk_round_rate() does not result in 666666660
>> (clk_round_rate() always rounds down!), we chose to put 666667 in the OPP. This
> What is OPP?

Operating Performance Point (Documentation/power/opp.txt describes
frequencies in Hz, the bindings we chose in the community
Documentation/devicetree/bindings/power/opp.txt describes it in KHz).

Regards,
Nishanth Menon
