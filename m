From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Sep 2014 17:21:12 +0100
Subject: [PATCH v7 1/3] mfd: devicetree: bindings: Add Qualcomm RPM DT
 binding
In-Reply-To: <20140924155319.GA28481@sonymobile.com>
References: <1411428329-23172-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1411428329-23172-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20140924082228.GF17801@lee--X1>
 <20140924155319.GA28481@sonymobile.com>
Message-ID: <20140924162112.GB7113@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Sep 2014, Bjorn Andersson wrote:

> On Wed 24 Sep 01:22 PDT 2014, Lee Jones wrote:
> 
> > On Mon, 22 Sep 2014, Bjorn Andersson wrote:
> > 
> > > Add binding for the Qualcomm Resource Power Manager (RPM) found in 8660,
> > > 8960 and 8064 based devices. The binding currently describes the rpm
> > > itself and the regulator subnodes.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  246 ++++++++++++++++++++
> > 
> > Please adhere to: Documentation/devicetree/bindings/submitting-patches.txt
> > 
> 
> I assume you mean this part:
> 
>   1) The Documentation/ portion of the patch should be a separate patch.
> 
> But I doubt this document was written with include/dt-bindings in mind, because
> in my eyes they are part of "device tree bindings".

Actually, this is an oversight on my part.  If I would have seen that
this patch only touched the bindings and include/dt-bindings I
probably wouldn't have said anything.

This patch still needs a DT Ack though.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
