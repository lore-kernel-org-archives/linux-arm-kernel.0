From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 22:18:09 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.20
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a2ZUdGLG-vVT0MqbZmory6GEVEefZY=6NYMQ=3-kHkZNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 12:23 PM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC drivers updates for v4.20.
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.20
>
> for you to fetch changes up to fae210bb5bfbd29118e18881f7108c6bd59293b9:
>
>   dt-bindings: apmu: Document r8a7744 support (2018-09-24 17:21:12 +0200)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Drivers Updates for v4.20
>
> * Convert to SPDX identifiers
> * R-Car V3M (r8a77970) and V3H (r8a77980): Document Timer Unit (TMU) bindings
> * RZ/G1N (r8a7744) and RZ/G1C (r8a77470) SoCs:
>   - Document APMU and SMP enable method
> * RZ/G2M (r8a74a1), RZ/G1N (r8a7744) and RZ/G2E (r8a774c0) SoCs:
>   - Add reset support
>   - Add sysc support
> * RZ/G2M (r8a774a1), RZ/G2E (r8a774c0) and RZ/A2M (r7s9210) SoCs:
>   - Add support for identifying SoC
> * RZ/A2M (r7s9210) SoC:
>   - Add basic SoC setup support


Pulled into next/drivers, thanks

        Arnd
