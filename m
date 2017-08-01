From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Aug 2017 16:49:00 +0800
Subject: [linux-sunxi] [PATCH v3 06/12] ASoC: sun4i-i2s: Add changes for
 wss and sr
In-Reply-To: <20170729141753.20174-7-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-7-codekipper@gmail.com>
Message-ID: <CAGb2v65cn6=BKS=jdOuX3j7xPcdjt5FKDGdN=MZrTNiWTsCNMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On newer SoCs the location of the slot width select and sample
> resolution are different and also there is a bigger range of
> support.

There is enough space to not use acronyms in the commit subject line.

    ASoC: sun4i-i2s: Add regfields for word size select and sample resolution

would be much clearer.

>
> For the current supported rates then an offset is required.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
