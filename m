From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Jun 2012 02:27:38 +0200
Subject: Follow-up to remaining issue with alignment of __log_buf in
 printk.c
In-Reply-To: <87y5np1qks.fsf@free.fr>
References: <87aa05vgzg.fsf@free.fr> <4FDA3BB4.9040607@wwwdotorg.org>
 <87y5np1qks.fsf@free.fr>
Message-ID: <20120615002738.GH26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> PS: For Andrew, I saw your patch. It won't solve my problem as my compiler
> believes __alignof__(struct log) == 4 ... bad luck for me.
> 
> PPS: My toolchain is arm-2011.09

Hi Robert

I have gcc version 4.4.5 (Debian 4.4.5-8), both native and cross.

  Andrew
