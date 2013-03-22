From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Mar 2013 15:07:29 -0300
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <20130304031716.GC30431@S2101-09.ap.freescale.net>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <20130304031716.GC30431@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Ai-msRVeAqQFiRhfAxkb2DMTYJvTcYihBhFt6GMCFwPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Mar 4, 2013 at 12:17 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I do not understand why.  But it seems to me that applying the patch on
> top of v3.9-rc1 results in a silent audio playback on my imx28-evk
> board.  Can you confirm that on your side?

Can you please re-try against linux-next 20130322?

I tried it here and audio playback is normal with touchscreen enabled.
