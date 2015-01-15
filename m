From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 13:13:04 +0100
Subject: [PATCH v2] ARM: KVM: extend WFI tracepoint to differentiate
 between wfi and wfe
In-Reply-To: <1421081776-2350-1-git-send-email-andre.przywara@arm.com>
References: <1421081776-2350-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150115121304.GR26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 04:56:16PM +0000, Andre Przywara wrote:
> Currently the trace printk talks about "wfi" only, though the trace
> point triggers both on wfi and wfe traps.
> Add a parameter to differentiate between the two.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
Thanks, applied!

-Christoffer
