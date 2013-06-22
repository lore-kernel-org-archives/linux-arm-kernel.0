From: agnel.joel@gmail.com (Joel A Fernandes)
Date: Fri, 21 Jun 2013 19:07:07 -0500
Subject: [PATCH v12 00/11] DMA Engine support for AM33XX
In-Reply-To: <51C42A85.8090705@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <51C42A85.8090705@ti.com>
Message-ID: <CAD=GYpbjZJeebxaJ=zNc9R=pkSoVsu_3D9deaOr7enuONNc0wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Fri, Jun 21, 2013 at 5:27 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Joel,
>
> On 6/21/2013 2:36 AM, Joel A Fernandes wrote:
>> From: Joel A Fernandes <agnel.joel@gmail.com>
>>
>> This series is remaining of Matt Porter's EDMA patches for AM33XX EDMA support
>> with changes for few pending review comments on v11 series.
>
> I have posted a branch with fixes for patches accepted by me in this
> series (also posted inline as replies to specific patches).
>
> https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v3.11/soc-2
>
> Can you please give it a good test - especially on AM335x? I will send a
> pull request after you confirm. If you find bugs please send incremental
> patches so I can merge into the original patch.

This breaks on AM33XX due to dangling pointer, I sent a follow up
patch addressing it.

However, with this branch I still get..
mmc: unable to obtain RX DMA engine channel 25

Is there anything obvious you might have changed that is causing this?

Thanks,
Joel
