From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 20 Jan 2015 11:07:04 +0100
Subject: [PATCH 8/8] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1421747231-554-9-git-send-email-s.hauer@pengutronix.de>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-9-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1421748424.9655.107.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-20 at 10:47 +0100, Sascha Hauer wrote:
> From: Flora Fu <flora.fu@mediatek.com>
> 
> This adds support for the regulators on the MediaTek MT6397
> Multifunction device.
> 
> Signed-off-by: Flora Fu, MediaTek
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |  41 ++-

This looks new for linux-next ...

>  .../bindings/regulator/mt6397-regulator.txt        | 217 ++++++++++++++

but this is already in linux-next. See linux-next commit 269675757901
("regulator: Add document for MT6397 regulator"). And ...

>  drivers/regulator/Kconfig                          |   9 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/mt6397-regulator.c               | 332 +++++++++++++++++++++
>  include/linux/regulator/mt6397-regulator.h         |  49 +++

these are too. See linux-next commit 0425e2420c0a ("egulator: mt6397:
Add support for MT6397 regulator"). Unless there are difference that
can't be spotted by looking at the diffstats of those commist, that is.

I only noticed because I was looking at the progress of the patch that
adds MFD_MT6397, and found this series. (MFD_MT6397 is added in 7/8, by
the way.)

>  6 files changed, 626 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
>  create mode 100644 drivers/regulator/mt6397-regulator.c
>  create mode 100644 include/linux/regulator/mt6397-regulator.h


Paul Bolle
