From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:39:53 +0100
Subject: [PATCH v2 01/28] ARM: KVM: Move the  HYP code to its own section
In-Reply-To: <1454583645-10144-2-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209183953.GF5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:18AM +0000, Marc Zyngier wrote:
> In order to be able to spread the HYP code into multiple compilation
> units, adopt a layout similar to that of arm64:
> - the HYP text is emited in its own section (.hyp.text)
> - two linker generated symbols are use to identify the boundaries
>   of that section
> 
> No functionnal change.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
