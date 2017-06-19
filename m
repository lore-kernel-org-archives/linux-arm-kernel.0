From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:37:34 -0700
Subject: [GIT PULL] Amlogic defconfig updates for v4.13
In-Reply-To: <7hzidabgwf.fsf@baylibre.com>
References: <7hzidabgwf.fsf@baylibre.com>
Message-ID: <20170619033734.GO30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 10:47:28AM -0700, Kevin Hilman wrote:
> The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:
> 
>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-defconfig
> 
> for you to fetch changes up to b4cb6f0ab7b0c4dd7f5ba546abcc960caa57aa72:
> 
>   ARM64: defconfig: enable meson SPICC as module (2017-06-14 10:25:16 -0700)
> 
> ----------------------------------------------------------------
> Amlogic arm64 defconfig changes for v4.13
> - enable meson SPICC as module
> - enable IR core, decoders and Meson IR device
> 
> ----------------------------------------------------------------
> Neil Armstrong (2):
>       ARM64: defconfig: enable IR core, decoders and Meson IR device
>       ARM64: defconfig: enable meson SPICC as module

I nearly accidentally merged this into next/defconfig since it didn't have '64'
in the name. :)

Merged into next/arm64. Thanks.


-Olof
