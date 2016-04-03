From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 3 Apr 2016 12:08:33 +0200
Subject: [PATCH v4 02/12] KVM: arm/arm64: extend arch CAP checks to allow
 per-VM capabilities
In-Reply-To: <1458958450-19662-3-git-send-email-andre.przywara@arm.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <1458958450-19662-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20160403100833.GC5261@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 26, 2016 at 02:14:00AM +0000, Andre Przywara wrote:
> KVM capabilities can be a per-VM property, though ARM/ARM64 currently
> does not pass on the VM pointer to the architecture specific
> capability handlers.
> Add a "struct kvm*" parameter to those function to later allow proper
> per-VM capability reporting.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
