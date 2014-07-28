From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 16:41:36 +0200
Subject: [PATCH v15 05/12] document: dt: add the binding on HiP04
In-Reply-To: <1406555876-11989-6-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5197605.IUcU7lsvpl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 21:57:49 Haojian Zhuang wrote:
> 
> +HiP04 D01 Board
> +Required root node properties:
> +       - compatible = "hisilicon,hip04-d01";
> +

As mentioned in my patch 04 comment, I think it's better
to refer to the SoC here rather than the board. Even if you
know that there is only one board with this particular SoC,
we don't normally document each board as there are so many of
them.

	Arnd
