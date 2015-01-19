From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Mon, 19 Jan 2015 10:01:49 +0100
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
Message-ID: <CAAObsKA9EgdmqAe8JxJ=8nKJy6MsenHv8cpDO6fBiutBtgEpGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2014 at 03:56, Dylan Reid <dgreid@chromium.org> wrote:
> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
> processor and is similar to the Venice2 reference platform.
>
> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
> and work on the 1366x768 models.  I haven't tried on the HD systems
> yet.
>
> WiFi does not yet work, it needs at least some PMIC changes to enable
> the 32k clock.
>
> The elan trackpad is not yet functional but hopefully will be soon as
> there are patches under review.
>
> There is also an issue on reboot because the TPM isn't reset.  It will
> cause the stock firmware to enter recovery mode.  This can be worked
> around by an EC-reset, press refresh and power at the same time.

Hi Dylan,

do you have any more information regarding this problem that could
save me some investigation?

Thanks,

Tomeu
