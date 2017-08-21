From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Aug 2017 16:29:49 +0100
Subject: [PATCH] arm64: dma-mapping: Do not pass data to
 gen_pool_set_algo()
In-Reply-To: <1502700947-22654-1-git-send-email-vladimir.murzin@arm.com>
References: <1502700947-22654-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170821152948.c55ux5y34drpzg2u@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 09:55:46AM +0100, Vladimir Murzin wrote:
> gen_pool_first_fit_order_align() does not make use of additional data,
> so pass plain NULL there.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Both patches queued for 4.14. Thanks.

-- 
Catalin
