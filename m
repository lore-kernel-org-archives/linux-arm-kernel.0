From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 22 Nov 2014 21:01:13 +0100
Subject: [PATCH v2 1/3] KVM: arm64: ARMv8 header changes for page logging
In-Reply-To: <1416039550-28125-2-git-send-email-m.smarduch@samsung.com>
References: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
 <1416039550-28125-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141122200113.GR3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 15, 2014 at 12:19:08AM -0800, m.smarduch at samsung.com wrote:
> From: Mario Smarduch <m.smarduch@samsung.com>
> 
> This patch adds arm64 helpers to write protect pmds/ptes and retrieve 
> permissions while logging dirty pages. Also adds prototype to write protect 
> a memory slot and adds a pmd define to check for read-only pmds.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
