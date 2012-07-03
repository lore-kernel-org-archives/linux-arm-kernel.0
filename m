From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 03 Jul 2012 15:59:39 +0530
Subject: [PATCH v2] clk: __clk_set_parent: set uninitialized variable
In-Reply-To: <CAJOA=zN1FoFQmuht1R06n2xQbZ=g0aqN=5Lo2-v8MQx55qHmeg@mail.gmail.com>
References: <1341214902-15667-1-git-send-email-mkl@pengutronix.de>
 <4FF15EDF.7030806@ti.com>
 <CAJOA=zN1FoFQmuht1R06n2xQbZ=g0aqN=5Lo2-v8MQx55qHmeg@mail.gmail.com>
Message-ID: <4FF2C993.3060202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 July 2012 04:59 AM, Turquette, Mike wrote:
> Hi Rajendra and Marc,
>
> I prefer the code flow in Rajendra's change.  It seems more readable
> and has a negative diffstat;-)
>
> $ git diff --stat
>   drivers/clk/clk.c |   28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
>
> Rajendra, can you test and send a proper patch for the same?

Sure, will do.
