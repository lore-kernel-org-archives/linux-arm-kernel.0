From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Mon, 16 Feb 2015 10:31:22 +0000
Subject: [alsa-devel] [PATCH] ASoC: wm8731: let codec to manage clock
 by itself
In-Reply-To: <54DC62EA.5030503@atmel.com>
References: <1423121713-19434-1-git-send-email-voice.shen@atmel.com>
 <54DC62EA.5030503@atmel.com>
Message-ID: <20150216103122.GA1091@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 04:23:06PM +0800, Bo Shen wrote:
> Hi All,
>
> On 02/05/2015 03:35 PM, Bo Shen wrote:
>> Let the wm8731 codec to manage clock by itself.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>
>>   sound/soc/codecs/wm8731.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>
> Any comments for this patch (aka ping?)

I preferred the idea of having the clock as optional and from the
discussion on the last patch it didn't look too tricky to
achieve. OTOH I think the Atmel system is the only one that uses
both this CODEC and common clock so it doesn't look like this
would cause any problems, but might be nice for this not to be
one more thing for someone to fix up when moving a system to
common clock.

Thanks,
Charles
