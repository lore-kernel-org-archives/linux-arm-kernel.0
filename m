From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 Oct 2010 09:30:27 +0900
Subject: [alsa-devel] [PATCH 5/10] ARM: S5PV210: Add SCLK_SPDIF clock
In-Reply-To: <20101004183903.GF2835@opensource.wolfsonmicro.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286193154-17201-1-git-send-email-sw.youn@samsung.com>
	<20101004183903.GF2835@opensource.wolfsonmicro.com>
Message-ID: <AANLkTinz98X+L9-VeaL9nkUi1LKPtajibR3=d9ipXmns@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 3:39 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Oct 04, 2010 at 08:52:34PM +0900, Seungwhan Youn wrote:
>> This patch add SCLK_SPDIF clock to support source clock of S/PDIF
>> on S5PV210.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but this looks like an example of where the get and set rate operations
> could readily be shared as mentioned in reply to the previous patch.

Please see this in context of my reply to your previous comment.
