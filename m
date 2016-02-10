From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 10 Feb 2016 13:44:42 +0100
Subject: [PATCH 3/8] ARM: KVM: Enforce sorting of all CP tables
In-Reply-To: <1454931622-14902-4-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160210124442.GJ5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:40:17AM +0000, Marc Zyngier wrote:
> Since we're obviously terrible at sorting the CP tables, make sure
> we're going to do it properly (or fail to boot). arm64 has had the
> same mechanism for a while, and nobody ever broke it...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
