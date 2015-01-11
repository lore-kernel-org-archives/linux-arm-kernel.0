From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 13:40:01 +0100
Subject: [PATCH v3 1/2] KVM: arm/arm64: vgic: vgic_init returns -ENODEV
 when no online vcpu
In-Reply-To: <1418665413-31521-2-git-send-email-eric.auger@linaro.org>
References: <1418665413-31521-1-git-send-email-eric.auger@linaro.org>
 <1418665413-31521-2-git-send-email-eric.auger@linaro.org>
Message-ID: <20150111124001.GX21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 06:43:32PM +0100, Eric Auger wrote:
> To be more explicit on vgic initialization failure, -ENODEV is
> returned by vgic_init when no online vcpus can be found at init.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
