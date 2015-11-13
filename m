From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 13 Nov 2015 12:12:56 +0800
Subject: [PATCH v2 9/9] ARM: multi_v7_defconfig: Build AXP20X related
 drivers as modules
In-Reply-To: <1447387456-9912-11-git-send-email-wens@csie.org>
References: <1447387456-9912-1-git-send-email-wens@csie.org>
 <1447387456-9912-11-git-send-email-wens@csie.org>
Message-ID: <CAGb2v66WEiqgmx-3rL6ksuu-Zq+iridUcpu-Nshbnqcp7Pgfaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 12:04 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> axp20x support has been split into 2 parts, I2C and RSB interface
> variants.
>
> Update the MFD_AXP20X symbol for I2C support, and also enable
> MFD_AXP20X_RSB to support RSB variants. Build these drivers as
> modules.
>
> Keep MFD_AXP20X enabled for now, to ease migration for automated
> boot farms while the patches are being merged. This should be
> removed in the next release.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Sorry. This is an old file with an old commit message. Please see the
other patch 9 ("ARM: multi_v7_defconfig: Enable RSB and AXP20X related
drivers as modules").


ChenYu
