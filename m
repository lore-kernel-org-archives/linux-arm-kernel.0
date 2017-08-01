From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Aug 2017 16:18:11 +0800
Subject: [linux-sunxi] [PATCH v3 04/12] ASoC: sun4i-i2s: Add TX FIFO
 offset to quirks
In-Reply-To: <20170729141753.20174-5-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-5-codekipper@gmail.com>
Message-ID: <CAGb2v64P3Kc9MOe2SsVv4QjiwFfrvtjdd8z0OzjpqPQP+q3bkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> It has been seen that the newer SoCs have a different TX FIFO
> address. Add this to the quirks structure.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
