From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Mar 2018 10:53:00 +0100
Subject: [PATCH v2 00/10] R-Car M3-N: Enable EtherAVB device node
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180301095300.egvxwzpiuhwabwzg@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 11:22:44AM +0100, Jacopo Mondi wrote:
> Hi Simon, Geert,
>    in this second iteration I have dropped iommu dependencies for EtherAVB
> and have changed "phy-mode" for all mainlines Gen-3 boards, this time including
> ULCB, Draak, Eagle and V3MSK.
> 
> The series add phy-mode as a board property to the following board files:
> - salvator-common.dtsi
> - ulcb.dtsi
> - r8a77995-draak.dts
> - r8a77970-eagle.dts
> - r8a77970-v3msk.dts
> 
> And reset the EtherAVB phy-mode to "rgmii" in the following SoC DTSI:
> - r8a7795.dtsi
> - r8a7796.dtsi
> - r8a77995.dtsi
> - r8a77970.dtsi
> 
> And finally, I added EtherAVB device node for M3-N on top.

Thanks for the test report, applied.
