From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Dec 2015 12:49:48 +0100
Subject: [PATCH v2 18/21] arm64: KVM: Move away from the assembly version
 of the world switch
In-Reply-To: <1448650215-15218-19-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-19-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151202114948.GD18376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 06:50:12PM +0000, Marc Zyngier wrote:
> This is it. We remove all of the code that has now been rewritten.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
