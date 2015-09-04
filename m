From: kuleshovmail@gmail.com (Alexnader Kuleshov)
Date: Fri, 4 Sep 2015 23:12:47 +0600
Subject: [RFC PATCH 2/3] arm64: Introduce IRQ stack
In-Reply-To: <1441376587-12979-3-git-send-email-jungseoklee85@gmail.com>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
 <1441376587-12979-3-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20150904171247.GA1786@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jungseok,

On 09-04-15, Jungseok Lee wrote:
> +config IRQ_STACK
> +	bool "Use separate kernel stack when handling interrupts"
> +	depends on ARM64_4K_PAGES
> +	help
> +	  Say Y here if you want to use separate kernel stack to handle both
> +	  hard and soft interrupts. As reduceing memory footprint regarding
> +	  kernel stack, it benefits low memory platforms.

s/reduceing/reducing
