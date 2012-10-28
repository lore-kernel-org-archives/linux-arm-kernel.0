From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 28 Oct 2012 14:54:02 +0400
Subject: [PATCH 00/16] treewide: Convert dev_printk(KERN_<LEVEL> to
 dev_<level>(
In-Reply-To: <cover.1351411047.git.joe@perches.com>
References: <cover.1351411047.git.joe@perches.com>
Message-ID: <508D0ECA.8040008@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-10-2012 12:05, Joe Perches wrote:

> dev_<level> create smaller objects than dev_printk(KERN_<LEVEL>.
> Convert non-debug calls to this form.

> Joe Perches (16):
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
[...]
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
[...]
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(

    Hm, somehow this patch is repeated thrice?

MBR, Sergei
