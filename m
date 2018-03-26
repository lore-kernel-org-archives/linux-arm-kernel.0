From: sricharan@codeaurora.org (sricharan at codeaurora.org)
Date: Mon, 26 Mar 2018 15:17:46 +0530
Subject: [v9,04/15] clk: qcom: Add HFPLL driver
In-Reply-To: <20180325193341.27845-1-ctatlor97@gmail.com>
References: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
 <20180325193341.27845-1-ctatlor97@gmail.com>
Message-ID: <0132a9e1371c7e690d174cb4d65bc951@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-26 01:03, Craig Tatlor wrote:
> This doesn't seem to work correctly with the higher clocks on 8974pro,
> specifically 2150400000 hz or above, maybe its something to do with
> being bigger than an unsigned long.
> 
> When i try to set any higher frequency it jumps down to 300mhz.


  Thanks for testing this series. Not sure i got dropped from the list.
  So i will check on this and come back.

Regards,
  Sricharan
