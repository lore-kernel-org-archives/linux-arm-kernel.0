From: broonie@sirena.org.uk (Mark Brown)
Date: Tue, 6 Oct 2009 11:33:51 +0100
Subject: collie and SA1100 patches
In-Reply-To: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
Message-ID: <20091006103351.GD27168@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2009 at 11:35:24PM +0200, Thomas Kunze wrote:

> This patchset implements prober power management for collie. To archieve this
> some bugs were fixed and gpiolib-support was added to the ucb1x00 driver.
> Please tell me if I should CC some other people or lists.

>  drivers/mfd/ucb1x00-assabet.c              |    2 +-
>  drivers/mfd/ucb1x00-core.c                 |   89 ++++++-
>  drivers/mfd/ucb1x00-ts.c                   |    2 +-

This stuff probably ought to be CCed to Samuel Ortiz at least.
