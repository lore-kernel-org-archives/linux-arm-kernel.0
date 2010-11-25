From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Nov 2010 09:19:49 +0900
Subject: [PATCH] ARM: Samsung: Make sure ASoC DMA device is prototyped
In-Reply-To: <1290614502.3332.34.camel@odin>
References: <1290613983-1291-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1290614502.3332.34.camel@odin>
Message-ID: <006401cb8c36$7aec9a00$70c5ce00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Liam Girdwood wrote:
> 
> On Wed, 2010-11-24 at 15:53 +0000, Mark Brown wrote:
> > Ensure that the prototype agrees with the definition and stop sparse
> > complaining when building the file.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hi Mark and Liam,

I think this should be handled in your tree because I don't have Jassi's PATCHv4 series (18 patches) in my tree.
If required, will ask some branch or merge commit to you to merge into my tree for avoiding conflict later :-)

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
