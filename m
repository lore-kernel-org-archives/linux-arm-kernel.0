From: macro@linux-mips.org (Maciej W. Rozycki)
Date: Sun, 5 Apr 2015 23:23:10 +0100 (BST)
Subject: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
In-Reply-To: <1428258294.2775.69.camel@perches.com>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Message-ID: <alpine.LFD.2.11.1504052319340.21028@eddie.linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 5 Apr 2015, Joe Perches wrote:

>  drivers/tty/serial/dz.c                     | 2 +-
>  drivers/tty/serial/zs.c                     | 2 +-

 For these verified that the change works correctly, thanks for your work.

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
