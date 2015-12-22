From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 Dec 2015 10:30:35 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <20151222122154.GD26290@tiger>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
Message-ID: <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:21 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> I do not have this Kconfig option on my tree yet.

Yes, I know, but would this cause any issue?

This would allow etnaviv to be functional by default on 4.5. Otherwise
we should wait for 4.6.
