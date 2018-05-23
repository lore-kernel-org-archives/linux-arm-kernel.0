From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 23 May 2018 13:54:11 +0200
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <CAMuHMdVCPEChhbHsc1Tcp-zkBY5v8Mz+8qq-v3GVFifL_uLyeA@mail.gmail.com>
References: <20180523114340.10216-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVCPEChhbHsc1Tcp-zkBY5v8Mz+8qq-v3GVFifL_uLyeA@mail.gmail.com>
Message-ID: <cfd4d292-b80a-d8c1-028c-93e3337aef2a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2018 01:52 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Wed, May 23, 2018 at 1:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Add PMIC nodes to Porter and connect CPU DVFS supply. There is
>> one DA9063L and one DA9210 on Porter, the only difference from
>> the other boards is that DA9063L is at I2C address 0x5a rather
>> than 0x58 .
> 
> Ah, so porter needs the regulator quirk, too.

Most of the boards do in fact, they just miss the regulator nodes.
Silk to from what I can test locally.

>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
Best regards,
Marek Vasut
