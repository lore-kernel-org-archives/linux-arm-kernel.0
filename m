From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 3 Jan 2018 12:01:18 -0800
Subject: [RESEND PATCH v2 15/15] arm64: dts: msm8996: db820c: Add sound
 card support
In-Reply-To: <e03188a1-1db2-29ab-8112-015161125e0b@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-16-srinivas.kandagatla@linaro.org>
 <20180103002229.GV478@tuxbook>
 <e03188a1-1db2-29ab-8112-015161125e0b@linaro.org>
Message-ID: <20180103200118.GB478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 03 Jan 08:27 PST 2018, Srinivas Kandagatla wrote:

> Thanks for the comments,
> 
> On 03/01/18 00:22, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla at linaro.org wrote:
> > 
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[..]
> > > +	        lpass_q6_smmu: arm,smmu-lpass_q6 at 1600000 {
> > 
> > name this node "iommu"
> will rename it to arm,smmu at 1600000
> 

I don't think you're supposed to have , in the node names, and whenever
possible they should be generic names of the function.

So analog to "clock-controller", "dma-controller", "serial", "i2c" etc I
believe this should be "iommu".

Regards,
Bjorn
