From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 27 Mar 2015 17:01:01 +0100
Subject: [PATCH v3 08/11] KVM: arm/arm64: prepare GICv2 emulation to be
 handled by kvm_io_bus
In-Reply-To: <1427380778-942-9-git-send-email-andre.przywara@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>
 <1427380778-942-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20150327160101.GD5121@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 02:39:35PM +0000, Andre Przywara wrote:
> Using the framework provided by the recent vgic.c changes we register
> a kvm_io_bus device when initializing the virtual GICv2.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
