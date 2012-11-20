From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 20 Nov 2012 17:22:03 +0800
Subject: [PATCH 2/2] ASoC: atmel-pcm: add dma support
In-Reply-To: <20121120085728.GX10560@opensource.wolfsonmicro.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
 <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
 <20121120085728.GX10560@opensource.wolfsonmicro.com>
Message-ID: <50AB4BBB.7050308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/20/2012 16:57, Mark Brown wrote:
> On Tue, Nov 20, 2012 at 04:38:18PM +0800, Bo Shen wrote:
>> Change xfer_size name to apply to PDC and DMA aswell.
>> Specify overrun bit in interrupt mask.
>> Add dmaengine specific routines and replace PDC ones in
>> pcm_ops if appropriate.
>> Uses cyclic DMA API for queuing samples.
>
> If you're using dmaengine you really need a *very* good reason not to
> use the core dmaengine support...

You mean I should using the soc-dmaengine-pcm, am I right?

Best Regards
Bo Shen
