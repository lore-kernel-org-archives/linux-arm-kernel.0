From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 27 May 2011 19:36:16 +0400
Subject: [PATCH][Trivial] ARM: remove duplicate include
	from	arch/arm/mach-dove/common.c
In-Reply-To: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
Message-ID: <4DDFC4F0.4070204@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Jesper Juhl wrote:

> Remove duplicate linux/serial_8250.h include from 
> arch/arm/mach-dove/common.c that was introduced by commit 
> 5c60255149eece2a36ec9f5c99817b85f96fe8ec .

   Please also specify that commit's summary -- for the human readers.

> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

WBR, Sergei
