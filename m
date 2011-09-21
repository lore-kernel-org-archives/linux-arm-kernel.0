From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Sep 2011 15:59:12 +0100
Subject: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking for each
	DAIs separately
In-Reply-To: <1314609314-22162-1-git-send-email-b29396@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
Message-ID: <20110921145911.GD6245@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 05:15:14PM +0800, Dong Aisheng wrote:

> -static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
> +static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *soc_dai)

Applied, thanks.  But plain dai would have been a better name here.
