From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 14:25:44 +0800
Subject: [PATCH v7 0/4] IR support for A83T
In-Reply-To: <20180801094801.26627-1-embed3d@gmail.com>
References: <20180801094801.26627-1-embed3d@gmail.com>
Message-ID: <CAGb2v66oe71CEtqkB2S-AYRzGnTQiJjVPUoRPkefd=9aqK+XbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2018 at 5:47 PM, Philipp Rossak <embed3d@gmail.com> wrote:
> This patch series adds support for the sunxi A83T ir module and enhances
> the sunxi-ir driver. Right now the base clock frequency for the ir driver
> is a hard coded define and is set to 8 MHz.
> This works for the most common ir receivers. On the Sinovoip Bananapi M3
> the ir receiver needs, a 3 MHz base clock frequency to work without
> problems with this driver.
>
> This patch series adds support for an optinal property that makes it able
> to override the default base clock frequency and enables the ir interface
> on the a83t and the Bananapi M3.

Queued up for 4.20.

Thanks!
