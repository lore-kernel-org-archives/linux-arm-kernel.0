From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 04 Nov 2012 02:08:08 +0400
Subject: [PATCH] ARM: S3C64XX: Fix up IRQ mapping for balblair on
 Cragganmore
In-Reply-To: <1351861289-19691-1-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1351861289-19691-1-git-send-email-dp@opensource.wolfsonmicro.com>
Message-ID: <509595C8.6090605@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-11-2012 17:01, Dimitris Papastamos wrote:

> We are using S3C_EINT(4) instead of S3C_EINT(5).

> Change-Id: I84e77fd75d59c6b8fecbcb11e81dc78dbf07f156

    You still hasven't removed this line. :-)

> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

WBR, Sergei
