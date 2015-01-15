From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Jan 2015 18:31:48 -0800
Subject: [PATCH] Build a uImage with dtb already appended
In-Reply-To: <1421287693-23383-1-git-send-email-ottxor@gentoo.org>
References: <20110802143148.21599.22870.stgit@ponder>
 <1421287693-23383-1-git-send-email-ottxor@gentoo.org>
Message-ID: <CAOesGMh8ZXt4fbw-AKOVWTQ8X5bVC8gEOhDFLroOYt+S43xBrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 6:08 PM, Christoph Junghans <ottxor@gentoo.org> wrote:
> Add new targets to build zImage and uImage with DTB appended (i.e. make
> 'uImage-dtb.am335x-bone' or 'make zImage-dtb.omap3-evm').
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
>
> I don't know why this never got merged, but I think it is still useful.

Maybe the patch description on the first version of the patch is a hint?

https://lkml.org/lkml/2011/8/2/200

In general, we're moving away from generating custom images straight
out of the kernel build system. You should make that part of your
installation scripts or similar instead.


-Olof
