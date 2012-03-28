From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Mar 2012 10:45:27 +0800
Subject: [PATCH] Regulator: anatop-regulator: patching to device-tree
 property "reg".
In-Reply-To: <1332834841-13925-1-git-send-email-paul.liu@linaro.org>
References: <1332834841-13925-1-git-send-email-paul.liu@linaro.org>
Message-ID: <CAAQ0ZWRh30PhS_zDhG5U1s8vTjETNQ0auHa9oNRt+Pv4zeCN1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2012 15:54, Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org> wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> Change "reg" to "anatop-reg-offset" due to there is a warning of handling no
> size field in reg.
>
> This patch also adds the missing device-tree binding documentation.
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
