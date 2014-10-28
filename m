From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Tue, 28 Oct 2014 09:33:04 -0700
Subject: [PATCH 0/4] Enable PCI controller for Keystone SoCs
In-Reply-To: <544FBF4D.6000502@ti.com>
References: <1414173095-32511-1-git-send-email-m-karicheri2@ti.com>
 <544FBF1C.80305@ti.com> <544FBF4D.6000502@ti.com>
Message-ID: <544FC540.1050501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/28/2014 09:07 AM, Murali Karicheri wrote:
> On 10/28/2014 12:06 PM, Murali Karicheri wrote:
>> On 10/24/2014 01:51 PM, Murali Karicheri wrote:
>>> Now that Keystone PCI driver is merged to v3.18, this patch series
>>> add build options and DTS bindings to enable the driver for Keystone
>>> SoCs.
>>>
>>> CC : Santosh Shilimkar<santosh.shilimkar@gmail.com>
>>> CC : Greg Kroah-Hartman<gregkh@linuxfoundation.org>
>>> CC : Rob Herring<robh+dt@kernel.org>
>>> CC : Pawel Moll<pawel.moll@arm.com>
>>> CC : Mark Rutland<mark.rutland@arm.com>
>>> CC : Ian Campbell<ijc+devicetree@hellion.org.uk>
>>> CC : Kumar Gala<galak@codeaurora.org>
>>> CC : Russell King<linux@arm.linux.org.uk>
>>> CC : devicetree at vger.kernel.org
>>>
>>> Murali Karicheri (4):
>>> ARM: keystone: add pcie related options
>>> ARM: keystone: defconfig: add options to enable PCI controller
>>> ARM: keystone: dts: add DT bindings for PCI controller for port 0
>>> ARM: keystone: dts: add DT bindings for PCI controller for port 1
>>>
>>> arch/arm/boot/dts/k2e.dtsi | 45 +++++++++++++++++++++++++++++++++++
>>> arch/arm/boot/dts/keystone.dtsi | 45 +++++++++++++++++++++++++++++++++++
>>> arch/arm/configs/keystone_defconfig | 3 +++
>>> arch/arm/mach-keystone/Kconfig | 2 ++
>>> 4 files changed, 95 insertions(+)
>>>
>> Santosh,
>>
>> Could you review this and apply to your tree for merge by end of this
>> week if this looks good and there are no comments?
>>
> Adding Santosh's personal email ID
>
Just use the listed kernel.org id while posting patches which needs
my attention. Please repost the series again so that I have all the
patches.

Also what happened with the PCIE notifier related series ?
If you have already proposed something, please loop me on the thread.

Thanks and Regards,
Santosh
