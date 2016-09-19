From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 Sep 2016 21:48:35 +0200
Subject: [PATCH 2/4] ARM: sa11x0/pxa: acquire timer rate from the clock
 rate
In-Reply-To: <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <4a9fbd3b-7250-20e3-02af-c8a15d10bfd8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2016 21:12, Robert Jarzmik wrote:
> As both pxa and sa1100 provide a clock to the timer, the rate can be
> inferred from the clock rather than hard encoded in a functional call.
> 
> This patch changes the pxa timer to have a mandatory clock which is used
> as the timer rate.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
