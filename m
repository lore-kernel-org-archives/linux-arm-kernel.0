From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 00:22:04 -0200
Subject: [PATCH 1/1] power: reset: remove unused imx-snvs-poweroff driver
In-Reply-To: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
References: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5CwkAM1_bT_5e62j=aRJOCyu+uV1-S2UJH4+okyntUV8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 8:28 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> There's no user of it in kernel now and it basically functions the same
> as the generic syscon-poweroff.c to which we have already switched.
> So let's remove it.
>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
