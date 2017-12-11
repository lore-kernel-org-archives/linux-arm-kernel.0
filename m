From: davem@davemloft.net (David Miller)
Date: Mon, 11 Dec 2017 09:35:20 -0500 (EST)
Subject: [PATCH net-next v5 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <1512979049-15930-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1512979049-15930-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1512979049-15930-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20171211.093520.1509647114338216500.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Mon, 11 Dec 2017 16:57:29 +0900

> +static inline u32 ave_desc_read(struct net_device *ndev, enum desc_id id,
> +				int entry, int offset)

Do not use inline functions in foo.c files, let the compiler decide what
to do.

Thank you.
