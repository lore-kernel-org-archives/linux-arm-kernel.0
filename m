From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 Dec 2015 10:51:44 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <1450788454.2637.17.camel@pengutronix.de>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
 <1450788454.2637.17.camel@pengutronix.de>
Message-ID: <CAOMZO5A+=5Q9zqtAhvB9=Hx2QEsNATa3+Dv7x74q5ykAk1Tmtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:47 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> I don't see a need to rush this. We can always enable it in the -rc
> phase of 4.5 is we desire.
> But to be honest I would like to give etnaviv a cycle to stabilize
> until we enable it by default. With i.MX6QP now hitting the street and
> basically no testing of etnaviv being done there until now, I would
> rather not have it in the defconfig just now. It's not like it's hard
> for people willing to test this to enable a single Kconfig option...

Ok, let's enable it in 4.5-rc1.
