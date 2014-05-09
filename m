From: agross@codeaurora.org (Andy Gross)
Date: Fri, 9 May 2014 12:00:44 -0500
Subject: [PATCH] pinctrl: msm: Add more MSM8X74 pin definitions
In-Reply-To: <CACRpkdaZowxds1pLEEvaWwro2u=ycivzEwLkW0=Q2dgbTj3H9g@mail.gmail.com>
References: <1399005842-27898-1-git-send-email-agross@codeaurora.org>
 <CACRpkdaZowxds1pLEEvaWwro2u=ycivzEwLkW0=Q2dgbTj3H9g@mail.gmail.com>
Message-ID: <20140509170044.GA26165@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 10:37:00AM +0200, Linus Walleij wrote:
> On Fri, May 2, 2014 at 6:44 AM, Andy Gross <agross@codeaurora.org> wrote:
> 
> > This patch adds pin definitiones for the MSM8x74 TLMM.  New definitions
> > include:
> >
> > BLSP devices (I2C, UART, UART flow control, SPI, and UIM), mi2s, gp clk, pdm,
> > gcc clk, cci_timer, cci_i2c, cam_clk, hsic, tsif, sdc3, sdc4, and other assorted
> > pins.
> >
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> 
> This patch does not apply on top of the pin control "devel" branch,
> can you please rebase it on my tree, branch devel?
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/

Sure thing.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
