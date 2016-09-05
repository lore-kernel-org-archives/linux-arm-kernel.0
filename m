From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 5 Sep 2016 13:28:59 +0200
Subject: [PATCH v2 1/7] arm64: KVM: Move GIC accessors to arch_gicv3.h
In-Reply-To: <1471344418-19568-2-git-send-email-vladimir.murzin@arm.com>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
 <1471344418-19568-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160905112859.GG26366@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 11:46:52AM +0100, Vladimir Murzin wrote:
> Since we are going to share vgic-v3 save/restore code with ARM
> keep arch specific accessors separately.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
