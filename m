From: john.stultz@linaro.org (John Stultz)
Date: Thu, 27 Oct 2016 13:23:09 -0700
Subject: [PATCH v2 2/2] arm64: dts: hi6220: add resets property into dwmmc
 nodes
In-Reply-To: <CAKfTPtB0FtGbm4C5z+LJizrsHikKt_BGFti5XY+LN3w7zO1Vjw@mail.gmail.com>
References: <1472094041-5357-1-git-send-email-guodong.xu@linaro.org>
 <1472094041-5357-2-git-send-email-guodong.xu@linaro.org>
 <CAKfTPtB0FtGbm4C5z+LJizrsHikKt_BGFti5XY+LN3w7zO1Vjw@mail.gmail.com>
Message-ID: <CALAqxLXfb48h8hMQmAaJ+YjA5=pekkQ8Dg8ReL6VTTfmuFRPDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 6:56 AM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> My hikey board failed to detect and mount sdcard with v4.9-rc1 and i
> have bisected the issue to this patch. Once reverted, the sdcard is
> detected again.

Hrm.. I've not seen this w/ my v4.9-rc2 based tree, and I don't have
any mmc patches there.

Can you send me your .config and point me to any other patches you're
running with? Also do you have any details about the card in case its
card specific?

Guodong: Is there any bootloader dependency on that change?

thanks
-john
