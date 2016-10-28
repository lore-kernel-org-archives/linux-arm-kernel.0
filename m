From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 28 Oct 2016 15:26:40 +0800
Subject: [PATCH v2 2/2] arm64: dts: hi6220: add resets property into
 dwmmc nodes
In-Reply-To: <CAKfTPtAXdkKcfpHmUmQNwuJxO0PORcCf49noST_CCkZPigPwgw@mail.gmail.com>
References: <1472094041-5357-1-git-send-email-guodong.xu@linaro.org>
 <1472094041-5357-2-git-send-email-guodong.xu@linaro.org>
 <CAKfTPtB0FtGbm4C5z+LJizrsHikKt_BGFti5XY+LN3w7zO1Vjw@mail.gmail.com>
 <CALAqxLXfb48h8hMQmAaJ+YjA5=pekkQ8Dg8ReL6VTTfmuFRPDw@mail.gmail.com>
 <CAKfTPtAXdkKcfpHmUmQNwuJxO0PORcCf49noST_CCkZPigPwgw@mail.gmail.com>
Message-ID: <20161028072640.GB17266@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 08:43:51AM +0200, Vincent Guittot wrote:

[...]

> > running with? Also do you have any details about the card in case its
> > card specific?
> 
> The sdcard is quite common: sandisk ultra 16GB
> and my rootfs is on the sdcard

I'm using rootfs in emmc also have same failure.

> > Guodong: Is there any bootloader dependency on that change?
> 
> FYI, I use firmwares available in AOSP

I tried latest firmware [1], still cannot boot up until revert the
patch "arm64: dts: hi6220: add resets property into dwmmc nodes".

[1] http://builds.96boards.org/snapshots/hikey/linaro/uefi-openplatformpkg/latest/

Thanks,
Leo Yan
