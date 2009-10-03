From: krzysztof.h1@poczta.fm (Krzysztof Helt)
Date: Sat, 3 Oct 2009 07:42:49 +0200
Subject: [PATCH 7/7] [ARM] s3c-fb: Added color key blending.
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5E@bssrvexch01.BS.local>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5E@bssrvexch01.BS.local>
Message-ID: <20091003074249.2a8ae03d.krzysztof.h1@poczta.fm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2009 20:05:04 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> This feature allows blending based on color key value.
> Pixels with key value get blended with alpha1, while the rest
> gets blended with alpha0.
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 
> ---
>  arch/arm/plat-s3c/include/plat/s3c-fb.h |    2 ++
>  drivers/video/s3c-fb.c                  |   27 ++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>




----------------------------------------------------------------------
Zobacz najwiekszy samolot na swiecie!  
Kliknij >>> http://link.interia.pl/f238f
