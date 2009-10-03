From: krzysztof.h1@poczta.fm (Krzysztof Helt)
Date: Sat, 3 Oct 2009 07:35:09 +0200
Subject: [PATCH 4/7] [ARM] s3c-fb: Corrected and added new VIDOSD
	register macros.
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5B@bssrvexch01.BS.local>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5B@bssrvexch01.BS.local>
Message-ID: <20091003073509.915f6747.krzysztof.h1@poczta.fm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2009 20:04:57 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> For S3C64xx, only windows 1 and 2 have VIDOSD_D registers.
> The VIDOSD_x register functions differ depending on the window number, as
> does the ability of setting up size and alpha:
> 
> win0: size in VIDOSD_C
> win1-2: alpha in VIDOSD_C and size in VIDOSD_D
> win3-4: alpha in VIDOSD_C
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 
> ---
>  arch/arm/mach-s3c6400/include/mach/regs-fb.h |   14 +++++++-
>  arch/arm/plat-s3c/include/plat/regs-fb.h     |   44 +++++++++++++------------
>  drivers/video/s3c-fb.c                       |   27 ++++++++++------
>  3 files changed, 52 insertions(+), 33 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


---------------------------------------------------------------
Zapytaj wr??k?!
Kliknij >>> http://link.interia.pl/f238d 
