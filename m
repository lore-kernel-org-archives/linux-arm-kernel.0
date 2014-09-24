From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Sep 2014 08:55:35 +0100
Subject: [PATCH v7 0/3] Qualcomm Resource Power Manager driver
In-Reply-To: <20140924042737.GQ10179@sonymobile.com>
References: <1411428329-23172-1-git-send-email-bjorn.andersson@sonymobile.com>
 <54212CA0.4030700@linaro.org>
 <20140924042737.GQ10179@sonymobile.com>
Message-ID: <20140924075535.GD17801@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Sep 2014, Bjorn Andersson wrote:

> On Tue 23 Sep 01:17 PDT 2014, Srinivas Kandagatla wrote:
> 
> > Hi Bjorn,
> > 
> > Thankyou for the new patchset.
> > 
> > I got few device-tree patches for apq8064 usb, sata, phy and hdmi which 
> > depend on rpm header file. It will be nice to get this functionality 
> > into 3.18.
> > 
> 
> We should be able to send out the dts patches separate of these.
> 
> > Do you think we should take these patches via arm-soc tree?
> > 
> 
> Both Lee and Mark indicated that they will pull the parts individually. However
> both of the patches depend on the header file created in patch 1, someone needs
> to take both for it to work out?

Once reviewed I can take the whole set with Mark's Ack.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
