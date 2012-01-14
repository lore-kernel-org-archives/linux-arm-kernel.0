From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jan 2012 20:34:35 +0100
Subject: [PATCH 2/2] mach-sa1100: modernize and cleanup timer code
In-Reply-To: <20120114120924.GQ1068@n2100.arm.linux.org.uk>
References: <1325672513-16725-1-git-send-email-linus.walleij@linaro.org>
 <20120112161034.GE2645@Boggieman>
 <CACRpkdYZaxfArU3_i3RuhxT1-wMM80gn6pnZG_mMwg=Ba-oRgQ@mail.gmail.com>
 <20120114084221.GM1068@n2100.arm.linux.org.uk>
 <CACRpkdYSKSV2cGrk5zTP5FhkkUc2Gvz344C=kqeheMAyNsfV8Q@mail.gmail.com>
 <20120114120924.GQ1068@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZskkFtzAVSX=rrxb1=NacLKiY0pZZ8ODevfwLQCE=oaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 1:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The only point I have on the patch is that it shouldn't use CLOCK_TICK_RATE
> lets try to get away from this horrible definition in mach/timex.h.

OK I'll replace that with (clockrate / HZ) as is custom.

Thanks!
Linus Walleij
