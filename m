From: claude.youn@gmail.com (Seungwhan Youn)
Date: Mon, 3 Jan 2011 10:30:05 +0900
Subject: [alsa-devel] [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio
	configuration
In-Reply-To: <20110102140129.GI4935@opensource.wolfsonmicro.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<1293172938-23615-1-git-send-email-sw.youn@samsung.com>
	<20110102140129.GI4935@opensource.wolfsonmicro.com>
Message-ID: <AANLkTi=yyE7X1Z-WSP6hj=vb2b38DW=BNm+A7Y=+k2wh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 2, 2011 at 11:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 24, 2010 at 03:42:18PM +0900, Seungwhan Youn wrote:
>> This patch adds SMDK audio select configurations based on platform dependacny.
>> This helps more easyly and clearly to make sure about configuration on audio
>> drivers support on platform side.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>
> This doesn't apply against current ASoC; I suspect it needs to be merged
> via the ARM tree.

Yes, patch 1/4 and 2/4 was based on Mr. Kukjin Kim's for-next branch.
So, I hope that Mr. Kukjin Kim sync with you, after he apply these 1,2
patches.
