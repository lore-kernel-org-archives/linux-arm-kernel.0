From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 8 Dec 2013 17:39:56 -0800
Subject: [PATCH][RESEND 5/8] uio: uio_pruss: use gen_pool_dma_alloc() to
 allocate sram memory
In-Reply-To: <f26a7fd466d22aaaeae9cf32d3c4c43c333e0b35.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
 <f26a7fd466d22aaaeae9cf32d3c4c43c333e0b35.1383306365.git.b42378@freescale.com>
Message-ID: <20131209013956.GA5385@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 07:48:18PM +0800, Nicolin Chen wrote:
> Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
