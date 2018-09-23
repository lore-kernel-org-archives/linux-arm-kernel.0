From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Sun, 23 Sep 2018 19:23:58 +0300
Subject: [PATCH 3/3] ARM: OMAP2PLUS: Remove references to AM3517-EVM since
 it's in DT
In-Reply-To: <20180923153718.15095-3-aford173@gmail.com>
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-3-aford173@gmail.com>
Message-ID: <adbc42d6-efae-20cf-64a2-994ccdffcd87@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/18 18:37, Adam Ford wrote:
> Since the audio codecs used on the AM3517-EVM are now available
> in device tree, and the audio driver wasn't really being used
> anyway, this patch removes the remaining AM3517 legacy board
> options and sound soc drivers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
For sound/soc/omap/ changes:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
