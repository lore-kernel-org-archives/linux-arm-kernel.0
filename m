From: zonque@gmail.com (Daniel Mack)
Date: Wed, 07 Aug 2013 17:59:29 +0200
Subject: [PATCH 07/20] spi: spi-pxa2xx: remove legacy PXA DMA bits
In-Reply-To: <20130807155549.GE6427@sirena.org.uk>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-8-git-send-email-zonque@gmail.com>
 <20130807155549.GE6427@sirena.org.uk>
Message-ID: <52026EE1.6000606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2013 17:55, Mark Brown wrote:
> On Wed, Aug 07, 2013 at 05:33:56PM +0200, Daniel Mack wrote:
>> Generic DMA support was already implemented by commit cd7bed00
>> ("spi/pxa2xx: break out the private DMA API usage into a separate
>> file") which moved all the legacy PXA DMA implementation code into
>> its own file.
> 
> Acked-by: Mark Brown <broonie@linaro.org>

Thanks.

> though this will have some trivial merge issues until the merge window
> they shouldn't be a problem.

Given the number of patches that need testing, I doubt this will hit the
3.12 window. But let's see :)


Daniel
