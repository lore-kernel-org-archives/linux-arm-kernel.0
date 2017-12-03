From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 16:56:32 -0800
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.15
In-Reply-To: <cover.1511781272.git.horms+renesas@verge.net.au>
References: <cover.1511781272.git.horms+renesas@verge.net.au>
Message-ID: <20171203005632.acle2wjdrzu2v4ci@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 12:17:41PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider this Renesas ARM based SoC DT fix for v4.15.
> 
> It is from Arnd adding missing '#reset-cells' property to cpg nodes.
> This flagged by recent dtc.
> 
> This pull request is based on
> "[GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.15"
> which is tagged as renesas-dt2-for-v4.15 and you have already pulled.
> 
> 
> The following changes since commit b6d3b649441936621c87b79bff8dd436e2397e3c:
> 
>   ARM: dts: r8a7743: Add xhci support to SoC dtsi (2017-10-18 07:21:36 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v4.15
> 
> for you to fetch changes up to 098f53050154498876ef3febde706ff5c8b25cf4:
> 
>   ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr (2017-11-20 11:35:41 +0100)

Merged, thanks.


-Olof
