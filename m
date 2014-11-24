From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Nov 2014 11:01:23 +0100
Subject: [PATCH v4 3/3] KVM: arm64: add irqfd support
In-Reply-To: <1416765420-12057-4-git-send-email-eric.auger@linaro.org>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
 <1416765420-12057-4-git-send-email-eric.auger@linaro.org>
Message-ID: <20141124100123.GK3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 06:57:00PM +0100, Eric Auger wrote:
> From: Joel Schopp <joel.schopp@amd.com>
> 
> This patch enables irqfd for arm64.
> 
> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> [Eric Auger]
> - originates from Joel's [RFC PATCH] arm64: KVM: add irqfd support
>   http://www.spinics.net/lists/kvm-arm/msg10798.html
> - isolates modifications really related to irqfd
> ---

This looks overly complicated to preserve authorship, if Joel is ok with
it, I suggest sqaushing this into the previous patch.

-Christoffer
