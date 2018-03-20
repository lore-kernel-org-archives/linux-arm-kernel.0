From: davem@davemloft.net (David Miller)
Date: Tue, 20 Mar 2018 12:09:35 -0400 (EDT)
Subject: [PATCH] net: gemini: fix memory leak
In-Reply-To: <1521441651-19753-1-git-send-email-igor.pylypiv@gmail.com>
References: <1521441651-19753-1-git-send-email-igor.pylypiv@gmail.com>
Message-ID: <20180320.120935.30641187502264005.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Pylypiv <igor.pylypiv@gmail.com>
Date: Sun, 18 Mar 2018 23:40:51 -0700

> cppcheck report:
> [drivers/net/ethernet/cortina/gemini.c:543]: (error) Memory leak: skb_tab
> 
> Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>

Applied, thanks.
