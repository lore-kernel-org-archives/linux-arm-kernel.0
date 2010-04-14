From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 14 Apr 2010 08:26:26 +0800
Subject: [PATCH] [ARM] pxa/imote2: Fix iMote2 defconfig
In-Reply-To: <1270735405-12088-1-git-send-email-stefan@datenfreihafen.org>
References: <1270735405-12088-1-git-send-email-stefan@datenfreihafen.org>
Message-ID: <j2uf17812d71004131726medd7f4eep3af28f6cc72b8624@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 8, 2010 at 10:03 PM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> - Bring in a CMDLINE that actually works and prints to the right tty
> - Compile-in JFFS2 to boot into rootfs
> - Remove unneeded options for Bluetooth and radio
> - Disable CPU_FREQ as it makes the flash driver fail
>
> Thanks Jonathan for spotting what I messed up.
>
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Applied to 'fix'.
