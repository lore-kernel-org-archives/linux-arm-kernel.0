From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 22 Dec 2015 13:47:34 +0100
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
Message-ID: <1450788454.2637.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 22.12.2015, 10:30 -0200 schrieb Fabio Estevam:
> On Tue, Dec 22, 2015 at 10:21 AM, Shawn Guo <shawnguo@kernel.org>
> wrote:
> 
> > I do not have this Kconfig option on my tree yet.
> 
> Yes, I know, but would this cause any issue?
> 
> This would allow etnaviv to be functional by default on 4.5.
> Otherwise
> we should wait for 4.6.
> 
I don't see a need to rush this. We can always enable it in the -rc
phase of 4.5 is we desire.
But to be honest I would like to give etnaviv a cycle to stabilize
until we enable it by default. With i.MX6QP now hitting the street and
basically no testing of etnaviv being done there until now, I would
rather not have it in the defconfig just now. It's not like it's hard
for people willing to test this to enable a single Kconfig option...

Regards,
Lucas
