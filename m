From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 20 Jun 2011 14:02:13 +0400
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate linux/leds.h
	include
In-Reply-To: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
Message-ID: <4DFF1AA5.80508@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-06-2011 12:40, Jesper Juhl wrote:

> Remove the duplicate inclusion of linux/leds.h from
> arch/arm/mach-s3c2410/h1940-bluetooth.c that was added by commit 50e2d10d.

    Pelase also specify that commit's summary in parens.

> Signed-off-by: Jesper Juhl<jj@chaosbits.net>

WBR, Sergei
