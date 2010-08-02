From: konkers@android.com (Erik Gilling)
Date: Mon, 2 Aug 2010 11:48:40 -0700
Subject: [PATCH] spi: add spi_tegra driver
In-Reply-To: <20100730075443.GA17814@avionic-design.de>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<20100730075443.GA17814@avionic-design.de>
Message-ID: <AANLkTikUjPaWs5h18pknvhSSCtvs+=pskNgNGrRmsvLD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 12:54 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
>
> Since you say this driver depends on the APB DMA driver, should this not be
> expressed as a Kconfig dependency? Something like:
>
> ? ? ? ?select TEGRA_SYSTEM_DMA

yep, will do.
