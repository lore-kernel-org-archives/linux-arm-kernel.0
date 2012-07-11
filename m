From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 11 Jul 2012 16:37:02 -0700
Subject: [GIT PULL] clk/mxs for 3.6
In-Reply-To: <20120705031526.GH2595@S2101-09.ap.freescale.net>
References: <20120703020006.GA22106@S2101-09.ap.freescale.net>
 <20120705031526.GH2595@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zPHG=KEcuMM_7guxCT5dAnhAs0+ZNDHD4WJZ7LC0tQR5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 8:15 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Jul 03, 2012 at 10:00:09AM +0800, Shawn Guo wrote:
>> The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:
>>
>>   Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)
>>
>> are available in the git repository at:
>>   git://git.linaro.org/people/shawnguo/linux-2.6.git clk/mxs-for-3.6
>>
>> Fabio Estevam (1):
>>       clk: mxs: Fix the GPMI clock name
>>
>> Huang Shijie (1):
>>       clk: mxs: rename the gpmi clock for imx28
>>
>> Shawn Guo (1):
>>       clk: mxs: add clkdev lookup for pwm
>>
>>  drivers/clk/mxs/clk-imx23.c |    3 ++-
>>  drivers/clk/mxs/clk-imx28.c |    3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> Mike,
>
> I just added one more patch on the branch.  Please pull it also.
>
> Lauri Hintsala (1):
>       clk: mxs: imx28: decrease the frequency of ref_io1 for SSP2 and SSP3

Done.

Thanks,
Mike

>
> --
> Regards,
> Shawn
>
