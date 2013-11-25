From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 25 Nov 2013 09:42:30 +0530
Subject: [PATCH v6 1/6] gpio: davinci: use readl/writel instead of __raw_*
In-Reply-To: <CAArO44vmfkroE9w4KviOhjkPvg9bTX9pAtr3oxYjD9u_wVZXeg@mail.gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
 <1385057731-4348-2-git-send-email-prabhakar.csengg@gmail.com>
 <CAArO44vmfkroE9w4KviOhjkPvg9bTX9pAtr3oxYjD9u_wVZXeg@mail.gmail.com>
Message-ID: <CA+V-a8sjmo2K16m9_6Zf1qwcez+qKm-9JW1Cb=Aj4prtXd=-fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Taras,

On Fri, Nov 22, 2013 at 3:38 PM, Taras Kondratiuk
<taras.kondratiuk@linaro.org> wrote:
> On 21 November 2013 20:15, Prabhakar Lad <prabhakar.csengg@gmail.com> wrote:
>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>
>> This patch replaces the __raw_readl/writel with
>> readl and writel, Altough the code runs on ARMv5
>> based SOCs, changing this will help copying the code
>> for other uses.
>
> This replacement has a functional impact: it adds memory barriers.
> Please note this in the description.
> Also please add a bit of explanation on why do you need to add barriers.
>
Agreed this adds memory barriers, I'll add a note about it.

Thanks,
--Prabhakar Lad
