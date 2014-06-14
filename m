From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Jun 2014 17:04:41 +0200
Subject: [PATCH v4 08/14] ARM: KVM: enable KVM in Kconfig on big-endian
 systems
In-Reply-To: <1402590613-3341-9-git-send-email-victor.kamensky@linaro.org>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
 <1402590613-3341-9-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140614150441.GF14023@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 09:30:07AM -0700, Victor Kamensky wrote:
> Previous patches addresses ARMV7 big-endian virtualiztion,
> kvm related issues, so enable ARM_VIRT_EXT for big-endian
> now.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
