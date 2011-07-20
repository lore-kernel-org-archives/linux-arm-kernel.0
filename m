From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 21 Jul 2011 00:49:28 +0800
Subject: [alsa-devel] [PATCH v4 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <4E26FF9D.1070000@ti.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
	<1311133306-9496-2-git-send-email-b29396@freescale.com>
	<4E26FF9D.1070000@ti.com>
Message-ID: <CAA+hA=SDDdf-Px1J_0CjE57QA2-n-=+=vH0Xpnqt=E5v1L1p7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/21 Liam Girdwood <lrg@ti.com>:
> On 20/07/11 04:41, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>> ---
>> ?sound/soc/mxs/mxs-pcm.c | ?359 +++++++++++++++++++++++++++++++++++++++++++++++
>> ?sound/soc/mxs/mxs-pcm.h | ? 43 ++++++
>> ?2 files changed, 402 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
>> new file mode 100644
>> index 0000000..f9063e7
>> --- /dev/null
>> +++ b/sound/soc/mxs/mxs-pcm.c
>> @@ -0,0 +1,359 @@
>> +/*
>
> snip
>
>> +
>> +static u64 mxs_pcm_dmamask = DMA_BIT_MASK(32);
>> +static int mxs_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
>> + ? ? ? struct snd_pcm *pcm)
>>
>
> This API has been updated to pass in the runtime data only. Can you redo against -next.
>

Yes, i will do that and send an updated version based on for-next branch.
BTW, please let me know if the driver has any more issues or the patch
series version may increase a lot. :)

Regards
Dong Aisheng
