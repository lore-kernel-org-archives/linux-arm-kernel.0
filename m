From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 11 Dec 2015 22:21:16 +0100
Subject: [PATCH v3 11/22] arm64: KVM: Add patchable function selector
In-Reply-To: <1449485618-9443-12-git-send-email-marc.zyngier@arm.com>
References: <1449485618-9443-1-git-send-email-marc.zyngier@arm.com>
 <1449485618-9443-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151211212116.GI27689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:53:27AM +0000, Marc Zyngier wrote:
> KVM so far relies on code patching, and is likely to use it more
> in the future. The main issue is that our alternative system works
> at the instruction level, while we'd like to have alternatives at
> the function level.
> 
> In order to cope with this, add the "hyp_alternate_select" macro that
> outputs a brief sequence of code that in turn can be patched, allowing
> an alternative function to be selected.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
