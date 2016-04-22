From: pku.leo@gmail.com (Leo Li)
Date: Fri, 22 Apr 2016 00:33:22 -0500
Subject: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <20160307095021.7f9f7484@arm.com>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
 <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
 <20160307095021.7f9f7484@arm.com>
Message-ID: <CADRPPNRU=qy34p4hzYvzBPrt2uabSQfc0Xdd8K5v5B_JW01QJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2016 at 3:50 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, 7 Mar 2016 11:36:22 +0800
> Minghuan Lian <Minghuan.Lian@nxp.com> wrote:
>
>> Some kind of NXP Layerscape SoC provides a MSI
>> implementation which uses two SCFG registers MSIIR and
>> MSIR to support 32 MSI interrupts for each PCIe controller.
>> The patch is to support it.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>
> The DT binding still needs an Ack from the DT maintainers though (cc'd).

Marc,

Who will be responsible to pick this driver?  I see you are also one
of the maintainers for irqchip.  Can you pick up the driver?  The
binding has already gotten ACKed by the device tree maintainer.

Regards,
Leo
