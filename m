From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Sep 2016 22:43:51 +0800
Subject: [PATCH 00/19] ARM: imx legacy: move peripheral initializations
 to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <20160920144351.GH3744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 04:36:28AM +0300, Vladimir Zapolskiy wrote:
> Vladimir Zapolskiy (19):
>   ARM: imx legacy: kzm: move peripheral initialization to .init_late
>   ARM: imx legacy: mx31lite: move peripheral initialization to .init_late
>   ARM: imx legacy: mx31ads: move peripheral initialization to .init_late
>   ARM: imx legacy: mx31lilly: move peripheral initialization to .init_late
>   ARM: imx legacy: pcm037: move peripheral initialization to .init_late
>   ARM: imx legacy: mx31-3ds: move peripheral initialization to .init_late
>   ARM: imx legacy: qong: move peripheral initialization to .init_late
>   ARM: imx legacy: armadillo5x0: move peripheral initialization to .init_late
>   ARM: imx legacy: mx31moboard: move peripheral initialization to .init_late
>   ARM: imx legacy: vpr200: move peripheral initialization to .init_late
>   ARM: imx legacy: imx27-visstrim-m10: move peripheral initialization to .init_late
>   ARM: imx legacy: mx27-3ds: move peripheral initialization to .init_late
>   ARM: imx legacy: mx35-3ds: move peripheral initialization to .init_late
>   ARM: imx legacy: apf9328: move peripheral initialization to .init_late
>   ARM: imx legacy: scb9328: move peripheral initialization to .init_late
>   ARM: imx legacy: pcm043: move peripheral initialization to .init_late
>   ARM: imx legacy: mx21ads: move peripheral initialization to .init_late
>   ARM: imx legacy: mx27ads: move peripheral initialization to .init_late
>   ARM: imx legacy: pca100: move peripheral initialization to .init_late

Applied all, except patch #14 (apf9328) and #15 (scb9328), which are
removed during this development cycle.

Shawn
