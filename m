From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 20 Mar 2014 13:45:57 +0100
Subject: [PATCH v3 1/3] clk: s2mps11: Add support for S2MPS14 clocks
In-Reply-To: <20140319191117.30995.13715@quantum>
References: <1395047958-17953-1-git-send-email-k.kozlowski@samsung.com>
 <1395047958-17953-2-git-send-email-k.kozlowski@samsung.com>
 <20140319001643.30995.46947@quantum> <1395215408.18730.2.camel@AMDC1943>
 <20140319191117.30995.13715@quantum>
Message-ID: <1395319557.22979.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-03-19 at 12:11 -0700, Mike Turquette wrote:
> Quoting Krzysztof Kozlowski (2014-03-19 00:50:08)
> > On Tue, 2014-03-18 at 17:16 -0700, Mike Turquette wrote:
> > > Quoting Krzysztof Kozlowski (2014-03-17 02:19:16)
> > > > This patch adds support for S2MPS14 PMIC clocks (BT and AP) to the
> > > > s2mps11 clock driver.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > Reviewed-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> > > > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > > 
> > > This does not apply cleanly to to clk tree trip, nor does it compile
> > > after manually merging due to changes introducing
> > > linux/mfd/samsung/s2mps14.h.
> > > 
> > > The changes look OK to me so maybe Lee can take it with my Ack?
> > > 
> > > Acked-by: Mike Turquette <mturquette@linaro.org>
> > > 
> > 
> > Hi,
> > 
> > Thanks for the Ack. The patch depends on Tushar Behera's patches:
> >  - [PATCH V2 0/2] Add support for clocks in S5M8767
> >    http://thread.gmane.org/gmane.linux.kernel.samsung-soc/27264
> > which are waiting for some time. Both patchsets should be pulled
> > together.
> 
> I took those patches in yesterday. So we have three options:

Great! Thanks.

> 
> 1) MFD tree can pull a stable commit from the clk tree. I'm happy to
> make a topic branch for this. Then these patches can be applied.
> 
> 2) clk tree can pull a stable commit from the mfd tree if the mfd folks
> can provide one.
> 
> 3) Wait until after the merge window to apply this one to the clk tree.
> I don't currently plan to send 2 PRs during the merge window, so this
> could either go in 3.16 or maybe into 3.15 if a split PR is sent.

Dear Lee,

How do you wish to proceed? The patchset depends on changes in sec-core
MFD driver.

Best regards,
Krzysztof
