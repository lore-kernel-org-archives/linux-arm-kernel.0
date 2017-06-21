From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 21 Jun 2017 20:26:07 +0000
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <20170503194600.16089-1-bart.vanassche@sandisk.com>
References: <20170503194600.16089-1-bart.vanassche@sandisk.com>
Message-ID: <1498076766.26050.1.camel@wdc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-03 at 12:46 -0700, Bart Van Assche wrote:
> The global variable 'rd_size' is declared as 'int' in source file
> arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> drivers/block/brd.c. Fix this inconsistency. Additionally, remove
> the declarations of rd_image_start, rd_prompt and rd_doload from
> parse_tag_ramdisk() since these duplicate existing declarations
> in <linux/initrd.h>.

(replying to my own e-mail)

Hello Russell,

Did I send this patch to the right maintainer? If so, do you want to share
any feedback about this patch?

Thanks,

Bart.
