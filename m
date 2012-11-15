From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 12:06:33 +0000
Subject: [PATCH] ARM: pxa: remove pxa95x support
In-Reply-To: <1352970366-7154-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352970366-7154-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201211151206.33461.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Haojian Zhuang wrote:
> PXA95x isn't widely used. And it adds the effort on supporting
> multiple platform. So remove it.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Looks good to me, thanks for going through this.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Should I apply this straight into the arm-soc tree, or are you
going to send a pull request?
