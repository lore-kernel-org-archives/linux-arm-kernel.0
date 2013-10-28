From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 09:11:48 -0700
Subject: [PATCH v2 1/6] ASoC: sirf: add sirf platform driver which
 provides DMA
In-Reply-To: <1382912628-13796-1-git-send-email-Baohua.Song@csr.com>
References: <1382912628-13796-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20131028161148.GC13643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 06:23:48AM +0800, Barry Song wrote:

> +static struct snd_pcm_hardware sirf_pcm_hardware = {
> +	.info                   = (SNDRV_PCM_INFO_MMAP
> +			| SNDRV_PCM_INFO_MMAP_VALID

Can you please try the recently added support for automatically
discovering the configuration from the dmaengine driver rather than hard
coding things?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/acf1d29c/attachment.sig>
