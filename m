From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 8 Dec 2010 18:52:36 +0800
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <19711.13023.154958.539289@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
	<19711.13023.154958.539289@ipc1.ka-ro>
Message-ID: <AANLkTikb4Ytx==R=n7RDOXv+tKtVvgcTUX7R-QDQfVoc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Thanks for the review.

On Wed, Dec 8, 2010 at 3:25 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> Shawn Guo writes:
>> MXS-based SoCs implements iomux functions in block PINCTRL.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>> ---
>> Changes for v2:
>> ?- Define iomux_cfg_t as u64
> ? ? ^^^^^^^^^^^^^^^^^^^^^^^^^
> Really?
>
>> +typedef struct pad_desc {
>> + ? ? unsigned bank:12;
>> + ? ? unsigned pin:20;
>> + ? ? unsigned muxsel:8;
>> + ? ? unsigned ma:12;
>> + ? ? unsigned vol:8;
>> + ? ? unsigned pull:4;
>> +} iomux_cfg_t;
> ^^^^^^^^^^^^^^^^^
>
I did not pick the correct word.  What I meant is 64 bits.  Since this
error is in change log, I would fix it if there is v3 of the patch.

-- 
Regards,
Shawn
