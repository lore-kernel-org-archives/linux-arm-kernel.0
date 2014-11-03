From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 21:05:50 +0100
Subject: [PATCH v3 08/19] arm/arm64: KVM: dont rely on a valid GICH base
 address
In-Reply-To: <1414776414-13426-9-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20141103200550.GK16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:43PM +0000, Andre Przywara wrote:
> To check whether the vGIC was already initialized, we currently check
> the GICH base address for not being NULL. Since with GICv3 we may
> get along without this address, lets use the irqchip_in_kernel()
> function to detect an already initialized vGIC.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
