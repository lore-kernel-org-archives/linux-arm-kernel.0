From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 12:45:41 +0900
Subject: [GIT PULL 0/3] Second Round of Renesas ARM Based SoC DT Updates
 for v3.14
In-Reply-To: <cover.1387764079.git.horms+renesas@verge.net.au>
References: <cover.1387764079.git.horms+renesas@verge.net.au>
Message-ID: <20131224034541.GA7267@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Corrected subject: s/3.13.3.14 ]

On Mon, Dec 23, 2013 at 11:08:12AM +0900, Simon Horman wrote:
> Hi Kevin, Hi Olof, Hi Arnd,
> 
> Please consider this second round of Renesas ARM Based SoC DT Updates for
> v3.13. It is based on the first round, tagged as renesas-dt-for-v3.14,
> which you have already pulled.
> 
> 
> The following changes since commit 1fd219561a4afc51b5f257692f3581546434db5b:
> 
>   ARM: shmobile: marzen: enable HSPI0 in DTS (2013-12-10 17:27:25 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.14
> 
> for you to fetch changes up to bd0609896eabe2e64b75d7955ae5ecec528cf860:
> 
>   ARM: shmobile: koelsch: dts: Add gpio-keys device (2013-12-12 22:22:04 +0900)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC DT Updates for v3.13
> 
> * r8a7791 (R-Car M2) based Koelsch board
> - Add GPIO keys
> 
> * sh73a0 (SH-Mobile AG5) based kzm9g board
>   - Add FSI support
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (2):
>       ARM: shmobile: sh73a0: add FSI support via DTSI
>       ARM: shmobile: kzm9g: add FSI support for DTS
> 
> Laurent Pinchart (1):
>       ARM: shmobile: koelsch: dts: Add gpio-keys device
> 
>  arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 54 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    | 33 +++++++++++++++
>  arch/arm/boot/dts/sh73a0.dtsi                   |  9 +++++
>  3 files changed, 96 insertions(+)
> 
