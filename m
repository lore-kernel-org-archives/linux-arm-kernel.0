From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 09 Jul 2014 16:55:48 +0400
Subject: [PATCH] Removes FIXME message in usb.c
In-Reply-To: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
References: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
Message-ID: <53BD3BD4.9090602@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/09/2014 05:58 AM, Nicholas Krause wrote:

> This patch removes a fixme message in this file:wq for setting the usb 2

    The vim's commands interspersed with text? :-)

> speed on the board to the correct level. We need to depend on the
> bootloader for doing this as the wires may be shared for the other
> things on the board with the usb chipset.

> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
[...]

WBR, Sergei
