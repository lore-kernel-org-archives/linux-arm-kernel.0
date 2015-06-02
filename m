From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 2 Jun 2015 15:09:33 +0530
Subject: [PATCH v3] ARM: dts: mt8173: support arm64 cpuidle-dt
In-Reply-To: <CAJ+MC=5oORYein5Z12Nb3vLDC4DLoyqUEyqZH95=LQWHBP23Sw@mail.gmail.com>
References: <1432882906-7940-1-git-send-email-howard.chen@linaro.org>
 <20150529145552.GD18512@red-moon>
 <CAJ+MC=5oORYein5Z12Nb3vLDC4DLoyqUEyqZH95=LQWHBP23Sw@mail.gmail.com>
Message-ID: <CAP245DUD_5DeU1+0-sRPn_m_d-a1FA-nxv6m9y2WpzG4kQd+mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 12:47 PM, Howard Chen <howard.chen@linaro.org> wrote:

>> what changed in the interim ? v1->v2 the cluster idle state disappeared,
>
> The cluster idle won't be available in the near future and possibly never will,
> while the C1 state is ready and stable, so I split the C1 part out.

May I ask why cluster idle won't be available?
