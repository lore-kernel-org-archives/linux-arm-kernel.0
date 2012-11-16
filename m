From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 16 Nov 2012 10:43:15 +0800
Subject: [Patch v6 1/4] ARM: at91: atmel-ssc: add pinctrl support
In-Reply-To: <20121116010310.GG4387@opensource.wolfsonmicro.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
 <20121116010310.GG4387@opensource.wolfsonmicro.com>
Message-ID: <50A5A843.2060902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

On 11/16/2012 9:03, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 06:09:08PM +0800, Bo Shen wrote:
>> Add pinctrl support for atmel ssc peripheral
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>
> This generates lots of conflicts in the pinctrl stuff in the DTS - looks
> like it was generated against -next.  Can you please regenerate against
> my atmel branch with just the changes to add the pinmux information on
> the SSC nodes?  Or possbily this can just be applied direct to the
> pinctrl branch (we'll get an add/add conflict with the SSC nodes though
> that should be simple to resolve, a cross merge might be helpful).

As Mark suggested, would this patch be split into 2 patches? One is for 
atmel ssc add pinmux information go into ASoC tree, and the other add 
ssc node into dts file go into pinctrl tree. Would this be ok?

Thanks.

Best Regards,
Bo Shen
