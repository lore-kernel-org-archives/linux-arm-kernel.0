From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 15 Aug 2017 13:39:56 +0300
Subject: [PATCH 1/3] ARM: dts: r8a7745: add PFC support
In-Reply-To: <TY1PR06MB07025D9CE628A3D4CED37AA9B78D0@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <20170415202036.987901107@cogentembedded.com>
 <CAMuHMdUPda7Mjo_P8p1V5a20XOAYM6GFf8Jqf0KLUuO7zAODeA@mail.gmail.com>
 <TY1PR06MB07025D9CE628A3D4CED37AA9B78D0@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <b3bcd091-4f96-c37a-54ec-c8ee5b0fd916@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/15/2017 11:47 AM, Chris Paterson wrote:

>>> Define the generic R8A7745 part of the PFC device node.
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> It looks like the dependencies for this patch are met now [1].
> 
> Are you happy to accept this patch? (and presumably the others in the series for the sk-rzg1e board).
> 
> We plan to add GPIO support for r8a7745, but need this patch in place first.
> 
> 
> [1] https://patchwork.kernel.org/patch/9705249/

    Actually, R8A774x PFC support has hit the Linus' tree in the meanwhile.
Simon, please merge the .dts patches.

> Kind regards, Chris

MBR, Sergei
