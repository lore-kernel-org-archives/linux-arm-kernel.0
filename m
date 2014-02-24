From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 24 Feb 2014 12:33:10 +0200
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <92B0AE30-5CDF-43FC-8588-EEF0C5F86266@codeaurora.org>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
 <92B0AE30-5CDF-43FC-8588-EEF0C5F86266@codeaurora.org>
Message-ID: <1393237990.6481.15.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Fri, 2014-02-21 at 09:35 -0600, Kumar Gala wrote: 
> On Feb 20, 2014, at 6:38 PM, Bjorn Andersson <bjorn.andersson@sonymobile.com> wrote:
> 
> > This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> > The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> > engine with input/output FIFOs and an embedded i2c mini-core. The driver
> > supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> > generated for each block-size data transfer).
> > 
> > Cc: Andy Gross <agross@codeaurora.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---

<snip>

> > 
> > +config I2C_QUP
> > +	tristate "Qualcomm QUP based I2C controller"
> > +	depends on ARCH_MSM
> 
> ARCH_QCOM

There is no such symbol, still.

Regards,
Ivan 


> - k
> 
