From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Sat, 7 Jul 2018 13:29:18 +0200
Subject: [PATCH] sound: stm32: replace "%p" with "%pK"
In-Reply-To: <s5hpo00quk4.wl-tiwai@suse.de>
References: <20180706130703.22352-1-benjamin.gaignard@st.com>
 <s5hpo00quk4.wl-tiwai@suse.de>
Message-ID: <CA+M3ks7QL6t+HLHAiW3T8hDFDNyR494y4dM20jc8YXJ7-Xbd_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-06 16:59 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> On Fri, 06 Jul 2018 15:07:03 +0200,
> Benjamin Gaignard wrote:
>>
>> The format specifier "%p" can leak kernel addresses.
>> Use "%pK" instead.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> The code change itself is OK (apart from the subject prefix to be
> "ASoC").  But do we really want to patch manually every single place
> like this?  There are thousands of files using '%p'.

I have limited myself to the few remaining %p in STM32 architecture.

>
>
> thanks,
>
> Takashi
