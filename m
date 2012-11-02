From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 02 Nov 2012 16:15:30 +0400
Subject: [PATCH] ARM: S3C64XX: Fix up IRQ mapping for balblair on
 Cragganmore
In-Reply-To: <1351852733-3346-1-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1351852733-3346-1-git-send-email-dp@opensource.wolfsonmicro.com>
Message-ID: <5093B962.1060903@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-11-2012 14:38, Dimitris Papastamos wrote:

> We are using S3C_EINT(4) instead of S3C_EINT(5).

> Change-Id: Ia197069ddc736813f2711c763469eaf655ea58ac

    Remove this line please -- it has no place in the upstream patch.

> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

WBR, Sergei
