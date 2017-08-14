From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 18:09:16 +0800
Subject: [PATCH] arm64: allwinner: a64: pine64: Use dcdc1 regulator for
 mmc0
In-Reply-To: <1502516402-4661-1-git-send-email-jteki@openedev.com>
References: <1502516402-4661-1-git-send-email-jteki@openedev.com>
Message-ID: <CAGb2v67AJBdmx-aO2Th9x7n4GibtW+isrfEAZ+HBgnjbabzEUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 12, 2017 at 1:40 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> Since current tree support AXP803 regulators, replace
> fixed regulator with AXP803 dcdc1 regulator.
>
> Tested on pine64.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

There was a lot of (heated) discussion [1] around this change. Maxime
stated he would merge a patch with this change but ended up picking
a later version without it. I'll leave this to him when he gets back.

ChenYu

[1] https://www.spinics.net/lists/arm-kernel/msg595419.html
