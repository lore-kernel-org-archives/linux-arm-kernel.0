From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2009 20:09:24 +0000
Subject: Linux on Toradex Colibri PXA320
In-Reply-To: <52701260536728@webmail34.yandex.ru>
References: <52701260536728@webmail34.yandex.ru>
Message-ID: <20091211200924.GA12628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 04:05:28PM +0300, Dennis Semakin wrote:
> Hello everbody
> 
> Excuse me, but I want to ask you a something.

The very first you need to fix is whatever you're using to get these
kernel messages out.  It's clearly introducing corruption; there's
absolutely no need to print "kernel/printk.c" before every message
for starters, and it looks like that is overwriting some of the
original message.

Once you've sorted that problem out, please re-post.
