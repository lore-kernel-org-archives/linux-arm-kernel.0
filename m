From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 7 Jan 2015 14:05:21 +0100
Subject: [PATCH v15 05/11] KVM: arm: Add initial dirty page locking support
In-Reply-To: <1418628488-3696-6-git-send-email-m.smarduch@samsung.com>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-6-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150107130521.GE21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 11:28:02PM -0800, Mario Smarduch wrote:
> Add support for initial write protection of VM memslots. This patch
> series assumes that huge PUDs will not be used in 2nd stage tables, which is
> always valid on ARMv7
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
