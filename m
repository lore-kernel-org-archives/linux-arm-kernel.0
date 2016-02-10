From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 10 Feb 2016 13:44:36 +0100
Subject: [PATCH 2/8] ARM: KVM: Properly sort the invariant table
In-Reply-To: <1454931622-14902-3-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160210124436.GI5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:40:16AM +0000, Marc Zyngier wrote:
> Not having the invariant table properly sorted is an oddity, and
> may get in the way of future optimisations. Let's fix it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
