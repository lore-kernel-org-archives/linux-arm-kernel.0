From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Dec 2015 12:51:31 +0100
Subject: [PATCH v2 20/21] arm64: KVM: Cleanup asm-offset.c
In-Reply-To: <1448650215-15218-21-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151202115131.GF18376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 06:50:14PM +0000, Marc Zyngier wrote:
> As we've now rewritten most of our code-base in C, most of the
> KVM-specific code in asm-offset.c is useless. Delete-time again!
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
