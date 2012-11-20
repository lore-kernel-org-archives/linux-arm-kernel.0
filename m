From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Nov 2012 10:44:51 -0800
Subject: [PATCH 1/2] ARM: dts: exynos: Move the dwmmc aliases from
 smdk5250 dts to exynos
In-Reply-To: <1353432158-22999-1-git-send-email-dianders@chromium.org>
References: <1353432158-22999-1-git-send-email-dianders@chromium.org>
Message-ID: <CAOesGMjSP2nJYXccs7n_4u-RVcyhOniEA9nkayEH4GR8muj5ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 9:22 AM, Doug Anderson <dianders@chromium.org> wrote:
> The aliases for dwmmc were placed in the SMDK5250 dts file but really
> should be common for all exynos5250 boards.  Move it to the common CPU
> file.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
