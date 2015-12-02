From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Dec 2015 12:49:31 +0100
Subject: [PATCH v2 17/21] arm64: KVM: Map the kernel RO section into HYP
In-Reply-To: <1448650215-15218-18-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-18-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151202114931.GC18376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 06:50:11PM +0000, Marc Zyngier wrote:
> In order to run C code in HYP, we must make sure that the kernel's
> RO section in mapped into HYP (otherwise things break badly).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
