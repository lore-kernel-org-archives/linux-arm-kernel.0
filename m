From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 20 Jan 2014 12:45:42 +0100
Subject: [PATCH 2/2] clk: ux500: Staticize ux500_twocell_get
In-Reply-To: <20140115073631.GD11820@lee--X1>
References: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
 <1389764606-14102-2-git-send-email-sachin.kamat@linaro.org>
 <20140115073631.GD11820@lee--X1>
Message-ID: <CAPDyKFro5Zf-WoCANshvwSRCkwMKp26tCuatUzp2TvMEh1Qhxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2014 08:36, Lee Jones <lee.jones@linaro.org> wrote:
>> ux500_twocell_get is a local symbol.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> ---
>>  drivers/clk/ux500/u8500_of_clk.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>

Thanks! Pushed to my clk-next-ux500 branch.

Kind regards
Ulf Hansson

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
