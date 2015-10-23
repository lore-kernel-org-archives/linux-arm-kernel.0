From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 Oct 2015 09:37:45 +0800
Subject: [PATCH v2 1/3] ARM: sunxi: Introduce Allwinner for A83T support
In-Reply-To: <1445557577-27383-2-git-send-email-vishnupatekar0510@gmail.com>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
 <1445557577-27383-2-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <CAGb2v645Bwzdc1Uq0sR9SWqQH4htiO6qyPs28Hc5iOiJffXDHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 7:46 AM, Vishnu Patekar
<vishnupatekar0510@gmail.com> wrote:
> Allwinner A83T is octa-core cortex-a7 based SoC.
> It's clock control unit and prcm, pinmux are different from previous sun8i
> series.
> Its processor cores are arragned in two clusters 4 cores each,
> similar to A80.
>
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>

Could you also update Documentation/arm/sunxi/README, so it says A83T
is supported?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
