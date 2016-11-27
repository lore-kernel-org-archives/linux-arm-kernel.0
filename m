From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 27 Nov 2016 10:39:10 -0200
Subject: [PATCH 2/2] input: touchscreen: sample averaging for imx6ul_tsc
In-Reply-To: <1480232698-23075-2-git-send-email-guy.shapiro@mobi-wize.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1480232698-23075-2-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <CAOMZO5CCtLdH9_5vGXfqg1rAizngVc_EWaoE+JfcfTrMmJT4xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 5:44 AM, Guy Shapiro <guy.shapiro@mobi-wize.com> wrote:
> The i.MX6UL internal touchscreen controller contains an option to
> average upon samples. This feature reduces noise from the produced
> touch locations.
>
> This patch adds sample averaging support to the imx6ul_tsc device
> driver.
>
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
