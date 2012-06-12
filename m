From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 12 Jun 2012 12:27:14 +0900
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <1339470307-28223-1-git-send-email-tmac@hp.com>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
Message-ID: <20120612032713.GI10170@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 09:05:07PM -0600, T Makphaibulchoke wrote:
> Removing the memset function and adding the new source file include to
> arch/sh/boot/compressed/misc.c
> 
..

> Signed-off-by: T. Makphaibulchoke <tmac@hp.com>
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
