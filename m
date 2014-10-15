From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 15 Oct 2014 09:25:34 -0700
Subject: [PATCH v2 02/15] arm/arm64: KVM: pass down user space provided
 GIC type into vGIC code
In-Reply-To: <1408626416-11326-3-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20141015162534.GC14272@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:06:43PM +0100, Andre Przywara wrote:
> With the introduction of a second emulated GIC model we need to let
> userspace specify the GIC model to use for each VM. Pass the
> userspace provided value down into the vGIC code to differentiate
> later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
