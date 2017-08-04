From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 12:55:52 +0200
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Fixes for v4.13
In-Reply-To: <cover.1501499175.git.horms+renesas@verge.net.au>
References: <cover.1501499175.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a3j1mcv=pjg99PPTm2bptP4jkND_w+fTOuWsRVsFde=dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 1:12 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these third round of Renesas ARM based SoC fixes for v4.13.
>
> This pull request is based on v4.12-rc1 rather than earlier fixes for v4.13
> as it is unrelated to those fixes and their dependencies - arm64 DT updates
> for R-Car Gen 3 SoCs.
>
> This fix resolves a deadlock during boot on R-Car Gen 2 SoCs.
> The bug has been present since v4.1-rc1 but does not manifest in
> a deadlock until v4.13-rc1.
>

Pulled into fixes, thanks!

       Arnd
