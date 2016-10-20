From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 22:35:18 +0800
Subject: [PATCH v4 3/9] clk: sunxi-ng: Finish to convert to structures for
 arguments
In-Reply-To: <67333887b86b7fd838dd9d6523dc7e3d9a9ddeb4.1476196031.git-series.maxime.ripard@free-electrons.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <67333887b86b7fd838dd9d6523dc7e3d9a9ddeb4.1476196031.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67CWEEcC+AQ9MqsyKokTx2ZVXKqBSUFW_x7CfjHrL_JFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 10:28 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some clocks still use an explicit list of arguments, which make it a bit
> more tedious to add new parameters.
>
> Convert those over to a structure pointer argument to add as many
> arguments as possible without having to many noise in our patches, or a
> very long list of arguments.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
