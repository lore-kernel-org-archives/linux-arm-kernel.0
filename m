From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 17 Sep 2014 09:15:54 -0700
Subject: [PATCH v6 1/3] mfd: devicetree: bindings: Add Qualcomm RPM DT
 binding
In-Reply-To: <20140826072727.GB9574@lee--X1>
References: <1409029109-28769-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1409029109-28769-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20140826072727.GB9574@lee--X1>
Message-ID: <20140917161554.GJ30918@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Aug 2014, Lee Jones wrote:

> On Mon, 25 Aug 2014, Bjorn Andersson wrote:
> 
> > Add binding for the Qualcomm Resource Power Manager (RPM) found in 8660,
> > 8960 and 8064 based devices. The binding currently describes the rpm
> > itself and the regulator subnodes.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom,rpm.txt |  246 ++++++++++++++++++++
> >  include/dt-bindings/mfd/qcom,rpm.h                 |  154 ++++++++++++
> >  2 files changed, 400 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,rpm.txt
> >  create mode 100644 include/dt-bindings/mfd/qcom,rpm.h
> 
> Please use the same filename formatting as the existing files.

Are you going to resubmit this (and answer my question on the
regulator patch)?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
