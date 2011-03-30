From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 Mar 2011 09:31:19 +0900
Subject: [PATCH] sound/soc/pxa/zylonite.c: set .codec_dai_name in
	initializer
In-Reply-To: <1300448853-15651-1-git-send-email-ospite@studenti.unina.it>
References: <1300448853-15651-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20110330003113.GA2853@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 12:47:33PM +0100, Antonio Ospite wrote:
> Fix the initialization of .codec_dai_name in zylonite_dai initializer,
> do not mix it with the initialization of .codec_name which is set
> already a few lines above.

Applied, thanks.

As discussed via IRC please fix your mail setup so it can deliver to
hosts without MX records.  Please also try to cut down the CC lists a
bit - don't blindly trust get_maintainers.
