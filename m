From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 06:04:35 +0900
Subject: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <20131017102201.GK2443@sirena.org.uk>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
 <20131017102201.GK2443@sirena.org.uk>
Message-ID: <52644563.1000203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/13 19:22, Mark Brown wrote:
> On Wed, Oct 16, 2013 at 09:10:51PM +0200, Tomasz Figa wrote:
>> Since the patches extending support of amba-pl08x DMA engine driver to
>> PL080S DMA engine (PL080 modified by Samsung) found in Samsung S3C64xx
>> SoCs got merged into Linux 3.12, it is a good time to migrate the
>> platform to use this driver and drop the legacy DMA code.
>
Tomasz, very nice :-) Thanks.

> Tested-by: Mark Brown<broonie@linaro.org>
>
Mark, thanks for your test.

Applied this whole series.

- Kukjin
