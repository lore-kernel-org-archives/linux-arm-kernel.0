From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 6 Nov 2018 10:42:11 +0100
Subject: [PATCH 1/2] arm64: dts: r8a77990: Add SDHI device nodes
In-Reply-To: <OSBPR01MB229351FF35C839C4E9A7F19CD8CB0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20181105214117.11734-1-marek.vasut+renesas@gmail.com>
 <OSBPR01MB229351FF35C839C4E9A7F19CD8CB0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
Message-ID: <7ab702f0-e78c-94c5-b74f-bac1803fb513@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2018 06:26 AM, Yoshihiro Shimoda wrote:
> Hello Marek-san,

Hello Shimoda-san,

>> From: Marek Vasut, Sent: Tuesday, November 6, 2018 6:41 AM
>>
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: linux-renesas-soc at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
> 
> Thank you for the patch!
> 
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> I guess this patch and the 2/2 patch for ebisu have to be merged into a patch though.

I wonder about that, 1/2 is adding SDHI DT nodes for an SoC, 2/2 is
enabling SDHI on a particular board, which I think should be separate.

-- 
Best regards,
Marek Vasut
