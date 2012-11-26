From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 26 Nov 2012 10:04:28 +0800
Subject: [PATCH 3/3] ASoC: atmel-pcm: add dma support
In-Reply-To: <20121123142747.GP4529@opensource.wolfsonmicro.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
 <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
 <20121123142747.GP4529@opensource.wolfsonmicro.com>
Message-ID: <50B2CE2C.4080700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/23/2012 22:27, Mark Brown wrote:
> On Fri, Nov 23, 2012 at 02:14:17PM +0800, Bo Shen wrote:
>> Add dmaengine specific routines and replace PDC ones in
>> pcm_ops if appropriate.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> [voice.shen at atmel.com: adapt to soc dmaengine framework]
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>
> Why is this not just two separate drivers?

I am not sure I got your means.
As I understand, I should keep the driver using pdc and won't touch it.
And create new a new driver using dma, am I right?

or else, ...?

Best Regards
Bo Shen
