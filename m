From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 21:05:43 +0100
Subject: [PATCH v3 07/19] arm/arm64: KVM: move kvm_register_device_ops()
 into vGIC probing
In-Reply-To: <1414776414-13426-8-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-8-git-send-email-andre.przywara@arm.com>
Message-ID: <20141103200543.GJ16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:42PM +0000, Andre Przywara wrote:
> Currently we unconditionally register the GICv2 emulation device
> during the host's KVM initialization. Since with GICv3 support we
> may end up with only v2 or only v3 or both supported, we move the
> registration into the GIC probing function, where we will later know
> which combination is valid.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
