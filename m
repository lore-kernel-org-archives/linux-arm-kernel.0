From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 14:14:25 +0100
Subject: [PATCH v3 02/19] arm/arm64: KVM: pass down user space provided
 GIC type into vGIC code
In-Reply-To: <1414776414-13426-3-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20141103131425.GC16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:37PM +0000, Andre Przywara wrote:
> With the introduction of a second emulated GIC model we need to let
> userspace specify the GIC model to use for each VM. Pass the
> userspace provided value down into the vGIC code and store it there
> to differentiate later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Did you change anything since v2?

If not, care to apply my ack from last time?

-Christoffer
