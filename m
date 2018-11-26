From: vkoul@kernel.org (Vinod Koul)
Date: Mon, 26 Nov 2018 22:55:12 +0530
Subject: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device
 node
In-Reply-To: <bcda9f6ffc58c8457e8822226b751132@codeaurora.org>
References: <20181126142133.16966-1-govinds@codeaurora.org>
 <20181126144422.GU3175@vkoul-mobl.Dlink>
 <bcda9f6ffc58c8457e8822226b751132@codeaurora.org>
Message-ID: <20181126172512.GW3175@vkoul-mobl.Dlink>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govind,

On 26-11-18, 22:28, Govind Singh wrote:
> On 2018-11-26 20:14, Vinod Koul wrote:
> > On 26-11-18, 19:51, Govind Singh wrote:

> > Lastly, I am not sure, but should the wifi node be always enabled?
> > Should it not be enabled in the board dts file? Bjorn..?
> > 
> 
> yes, i some how missed this.
> I will mark the status disabled by default and enable from qcs404 evb dts.

No issues, also we have two DTS EVB-1000 and EVB-4000, please choose
accordingly and if common please use qcs404-evb.dtsi

-- 
~Vinod
