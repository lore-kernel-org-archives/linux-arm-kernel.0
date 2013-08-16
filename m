From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 11:35:13 +0200
Subject: [PATCH] u8500_defconfig: allow creation and mounting of devtmpfs
In-Reply-To: <1374176130-21209-1-git-send-email-andi@etezian.org>
References: <1374176130-21209-1-git-send-email-andi@etezian.org>
Message-ID: <CACRpkdYDLGaQJ+R0stejCLRY7sgdnEBqkBocfh0GqhD+WiLx3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 9:35 PM, Andi Shyti <andi@etezian.org> wrote:

> This patch enables CONFIG_DETTMPFS and CONFIG_DEVTMPFS_MOUNT
> flags for u8500 based devices.
>
> In this way it's possible to create a tmpfs/ramfs already in the
> early stages of the boot, allowing programs like udev/mdev to
> populate the /dev directory.
>
> Signed-off-by: Andi Shyti <andi@etezian.org>

Patch applied.

Yours,
Linus Walleij
