From: dianders@chromium.org (Doug Anderson)
Date: Wed, 12 Nov 2014 11:22:57 -0800
Subject: [PATCH v10 2/3] power-domain: rockchip: add power doamin driver
In-Reply-To: <1415690392-9278-3-git-send-email-caesar.wang@rock-chips.com>
References: <1415690392-9278-1-git-send-email-caesar.wang@rock-chips.com>
 <1415690392-9278-3-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=V-qhi5rPxe_WGcS1JAZba_euFY3YuUyO_4mbqvJPUtzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Mon, Nov 10, 2014 at 11:19 PM, Caesar Wang
<caesar.wang@rock-chips.com> wrote:
> +       pm_genpd_init(&pd->genpd, NULL, false);

As Dmitry pointed out in another context, maybe this should be
"pm_genpd_init(&pd->genpd, NULL, !is_on);"
