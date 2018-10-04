From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 17:11:55 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable CONFIG_MMC_UNIPHIER
In-Reply-To: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK8P3a0R+hj3owNUi_nW6avi5HgEb3GcNCAk0TTudGTMXrjGmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2018 at 2:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Enable the UniPhier SD controller driver.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to next/defconfig, thanks!

Note: I think it would actually be better to update both defconfig files in one
patch, since you are doing the same change on both.

     Arnd
