From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 12:52:51 +0200
Subject: [GIT PULL] Amlogic fixes for v4.13-rc
In-Reply-To: <7hefswqyrr.fsf@baylibre.com>
References: <7hefswqyrr.fsf@baylibre.com>
Message-ID: <CAK8P3a2seX3f3O1sURh8nTKDu-V6kY4mzAN4+t_NBxE23Xb20Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 7:52 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes
>
> for you to fetch changes up to 72fb2c852188ad75ab3badb55bf491925b9eba46:
>
>   ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition (2017-07-20 17:50:22 -0700)
>
> ----------------------------------------------------------------
> Amlogic fixes for v4.13-rc
> - 2 minor DT fixes

Pulled into fixes, thanks! The second patch looks fairly large for a
"minor fix", but I see
that it doesn't really do that much.

      Arnd
