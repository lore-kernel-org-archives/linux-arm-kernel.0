From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:29:45 -0800
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for
 v4.16
In-Reply-To: <CAK7LNAR+RgxHGa8ZgVUsUbJAeaQqvm-mh=Xrss-JHsDNM79t_A@mail.gmail.com>
References: <CAK7LNAR+RgxHGa8ZgVUsUbJAeaQqvm-mh=Xrss-JHsDNM79t_A@mail.gmail.com>
Message-ID: <20180105072945.psqhzleqlocghcse@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 10:35:38PM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (64bit) updates for the v4.16 merge window.
> Please pull!
> 
> 
> The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:
> 
>   Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt64-v4.16
> 
> for you to fetch changes up to dbdae8474e08fc1194102bef95dc96db435c15da:
> 
>   arm64: dts: uniphier: enable more serial ports for PXs3 ref board
> (2017-12-29 22:03:26 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v4.16
> 
> - clean up gpios properties by macro
> - add GPIO hog for PXs3 reference node
> - add has-transaction-translator property to generic-ehci nodes
> - enable more serial ports for PXs3 reference node

Merged, thanks!


-Olof
