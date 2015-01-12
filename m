From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 12 Jan 2015 08:35:53 +0100
Subject: [PATCH v4 5/7] ARM: zynq: Enable pinctrl
In-Reply-To: <CACRpkdam4x-cWjrDuWS-0oDD3eGq1_pD3bK6xWEffiOipfBcOg@mail.gmail.com>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-6-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdam4x-cWjrDuWS-0oDD3eGq1_pD3bK6xWEffiOipfBcOg@mail.gmail.com>
Message-ID: <b03b673497694585802f77a4e40fd80b@BN1BFFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2015 10:36 PM, Linus Walleij wrote:
> On Fri, Jan 9, 2015 at 4:43 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
>> Select pinctrl and the Zynq pinctrl driver.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> Tested-by: Andreas F?rber <afaerber@suse.de>
>> ---
>> Changes since RFC v2:
>>  - separate mach-zynq changes in their own patch
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Since we're only selecting some symbols and these will appear
> in the merge window this can be applied orthogonally in the Zynq
> tree target for ARM SoC.
> 

Applied to zynq/soc.

Thanks,
Michal
