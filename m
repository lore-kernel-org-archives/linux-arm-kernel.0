From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Tue, 20 Mar 2018 20:43:54 +0200
Subject: [PATCH v3 04/10] clk: qcom: Add DT bindings for CPU clock driver
 for msm8996
In-Reply-To: <152148159682.242365.14310882079879566131@swboyd.mtv.corp.google.com>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-5-git-send-email-ilialin@codeaurora.org>
 <152148159682.242365.14310882079879566131@swboyd.mtv.corp.google.com>
Message-ID: <016f01d3c07b$69839da0$3c8ad8e0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: Monday, March 19, 2018 19:47
> To: Ilia Lin <ilialin@codeaurora.org>; linux-arm-kernel at lists.infradead.org;
> linux-arm-msm at vger.kernel.org; linux-clk at vger.kernel.org;
> sboyd at codeaurora.org
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org;
> rnayak at codeaurora.org; robh at kernel.org; will.deacon at arm.com;
> amit.kucheria at linaro.org; tfinkel at codeaurora.org; ilialin at codeaurora.org;
> nicolas.dechesne at linaro.org; celster at codeaurora.org
> Subject: Re: [PATCH v3 04/10] clk: qcom: Add DT bindings for CPU clock driver
> for msm8996
> 
> Quoting Ilia Lin (2018-02-14 05:59:46)
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,kryocc.txt | 17
> +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> > new file mode 100644
> > index 0000000..e7cf15a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> > @@ -0,0 +1,17 @@
> > +Qualcomm CPUSS clock controller for Kryo CPUs
> > +----------------------------------------------------
> > +
> > +Required properties :
> > +- compatible : shall contain only one of the following:
> > +
> > +                       "qcom-msm8996-apcc"
> 
> Do you mean qcom,msm8996-apcc?

The naming is per Rob's requirement.

> 
> Rob?
