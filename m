From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Aug 2017 09:25:00 +0200
Subject: [GIT PULL 1/4] Allwinner arm64 defconfig changes for 4.14, round 2
In-Reply-To: <20170819075659.w2tndblqwhesniuv@wens.csie.org>
References: <20170819075659.w2tndblqwhesniuv@wens.csie.org>
Message-ID: <CAK8P3a2D0oC0fmN=x2UYdDP34JciM6ZJXB6MiLw+krX4c0bAdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 9:56 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> ----------------------------------------------------------------
> Allwinner arm64 defconfig changes for 4.14
>
> Enable X-Powers AXP series PMIC mfd and regulator support by default.
>
> ----------------------------------------------------------------
> Jagan Teki (2):
>       arm64: defconfig: Enable MFD_AXP20X_RSB
>       arm64: defconfig: Enable REGULATOR_AXP20X

Applied to next/arm64.

Just as a general comment, I think there is no point in splitting up
patches like this one in two. Just group defconfig in a combined
patch where it makes sense. The same goes e.g. for DT patches
when you apply the same change to multiple files, it can be a single
patch.

    Arnd
