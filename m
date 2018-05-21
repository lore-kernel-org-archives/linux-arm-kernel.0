From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 20 May 2018 20:17:08 -0700
Subject: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP
 EVMs
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/11/18 12:29 PM, Murali Karicheri wrote:
> Now that NetCP driver patches for K2G SoC is merged to linux-next master
> this series add patches to enable network driver on K2G ICE and GP EVMs.
> 
> Thanks
> 
> Applied the patches on top of latest linux-next master, built kernel and
> booted up on both EVMs. The logs are below
> 
> K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
> K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/
> 
> Murali Karicheri (4):
>    ARM: dts: k2g: add dt bindings to support network driver
>    ARM: dts: keystone-k2g-evm: Enable netcp network driver
>    ARM: dts: keystone-k2g-ice: Enable netcp network driver
>    ARM: keystone: k2g: enable micrel and dp83867 phys
> 
>   arch/arm/boot/dts/keystone-k2g-evm.dts    |  53 +++++++++++
>   arch/arm/boot/dts/keystone-k2g-ice.dts    |  59 ++++++++++++
>   arch/arm/boot/dts/keystone-k2g-netcp.dtsi | 147 ++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/keystone-k2g.dtsi       |  13 +++
>   arch/arm/configs/keystone_defconfig       |   2 +
>   5 files changed, 274 insertions(+)
>   create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi
> 
Looks good. Will add this to the queue for 4.19. Thanks !!

Regards,
Santosh
