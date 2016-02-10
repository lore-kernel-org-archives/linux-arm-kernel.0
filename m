From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 10 Feb 2016 13:44:47 +0100
Subject: [PATCH 5/8] ARM: KVM: Switch the CP reg search to be a binary
 search
In-Reply-To: <1454931622-14902-6-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160210124447.GK5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:40:19AM +0000, Marc Zyngier wrote:
> Doing a linear search is a bit silly when we can do a binary search.
> Not that we trap that so many things that it has become a burden yet,
> but it makes sense to align it with the arm64 code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
