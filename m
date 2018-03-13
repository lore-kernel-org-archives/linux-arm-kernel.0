From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 13 Mar 2018 11:19:10 -0700
Subject: [PATCH] arm64: dts: qcom: rename qcom,pcie devices to pcie
In-Reply-To: <20180313121345.2749183-1-arnd@arndb.de>
References: <20180313121345.2749183-1-arnd@arndb.de>
Message-ID: <20180313181910.GW18510@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 13 Mar 05:13 PDT 2018, Arnd Bergmann wrote:

> The node name for a PCIe host bridge must be "pcie" as required by
> the binging. dtc now warns about it:
> 

"binding", I presume...

> arch/arm64/boot/dts/qcom/apq8096-db820c.dtb: Warning (pci_bridge): /soc/agnoc at 0/qcom,pcie at 610000: node name is not "pci" or "pcie"
> arch/arm64/boot/dts/qcom/apq8096-db820c.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/arm64/boot/dts/qcom/msm8996-mtp.dtb: Warning (pci_bridge): /soc/agnoc at 0/qcom,pcie at 610000: node name is not "pci" or "pcie"
> arch/arm64/boot/dts/qcom/msm8996-mtp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> 
> This renames the nodes as appropriate.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
