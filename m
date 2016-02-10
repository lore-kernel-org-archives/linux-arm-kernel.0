From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 10 Feb 2016 13:44:52 +0100
Subject: [PATCH 4/8] ARM: KVM: Rename struct coproc_reg::is_64 to is_64bit
In-Reply-To: <1454931622-14902-5-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160210124452.GL5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:40:18AM +0000, Marc Zyngier wrote:
> As we're going to play some tricks on the struct coproc_reg,
> make sure its 64bit indicator field matches that of coproc_params.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
