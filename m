From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Dec 2017 02:25:35 +0000
Subject: [PATCH] clk: fix compile testing of scpi clk driver
In-Reply-To: <d01ed8fa-9f9e-adf6-3133-800433fef7bb@gmail.com>
References: <24058ecb-9f12-f7e1-503d-bd98eb894c6c@gmail.com>
 <20171129170453.GA7698@codeaurora.org>
 <d01ed8fa-9f9e-adf6-3133-800433fef7bb@gmail.com>
Message-ID: <20171204022535.GE6870@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 09:37:46PM +0100, Heiner Kallweit wrote:
> Am 29.11.2017 um 18:04 schrieb Stephen Boyd:
> > On 11/28, Heiner Kallweit wrote:
> >> We now have a hard dependency on ARM_SCPI_PROTOCOL and may end up with
> >> the following error:
> >> ERROR: "get_scpi_ops" [drivers/clk/clk-scpi.ko] undefined!
> >> Fix this by removing COMPILE_TEST from COMMON_CLK_SCPI dependencies.
> >>
> >> Fixes: f7fee8be06a6 "firmware: arm_scpi: remove default for get_scpi_ops if not reachable"
> > 
> > I don't see this commit anywhere. Is this a future issue?
> > 
> Sorry, yes it is and the patch was primarily addressed to Sudeep. See here:
> https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scpi

I was trying to figure the build regression that the above commit would
cause as I could not find it myself but I was sure about the regression.

If I had pulled it officially ;), I would have responded to your original
patch. Sorry for the name of the brnach, I should have used something else
to avoid the confusion.

--
Regards,
Sudeep
