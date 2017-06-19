From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:38:05 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.13
In-Reply-To: <7htw3ibgut.fsf@baylibre.com>
References: <7htw3ibgut.fsf@baylibre.com>
Message-ID: <20170619033805.GQ30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 10:48:26AM -0700, Kevin Hilman wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt
> 
> for you to fetch changes up to 2c323c43a3d619d67bffa57dc7480cfae4c53300:
> 
>   ARM: dts: meson8: add and use the real clock controller (2017-06-09 11:21:21 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 32-bit DT changes for v4.13:
> - minor reorganization to support different busses
> - add/use real clock controller
> 
> ----------------------------------------------------------------
> Carlo Caione (1):
>       ARM: dts: meson: Extend L2 cache controller node for Meson8 and Meson8b
> 
> Martin Blumenstingl (3):
>       ARM: dts: meson: organize devices in their corresponding busses
>       ARM: dts: meson8b: inherit meson.dtsi from meson8b.dtsi
>       ARM: dts: meson8: add and use the real clock controller

Merged, thanks.


-Olof
