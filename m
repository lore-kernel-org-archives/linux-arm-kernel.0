From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 12 Jun 2010 17:15:09 +0800
Subject: [PATCH 2/3] pxa: Fix all devices using wm97xx_batt.h
In-Reply-To: <20100607091743.GB23093@rakim.wolfsonmicro.main>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
	<1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
	<20100607091743.GB23093@rakim.wolfsonmicro.main>
Message-ID: <AANLkTilkdPTchodUTXgpc2-7PcuJTPzX2vSqpHu4jjXt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 7, 2010 at 5:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jun 04, 2010 at 03:07:33AM +0200, Marek Vasut wrote:
>> This file is scheduled for removal, therefore fix all devices that use this
>> file to use the suggested wm97xx.h and pass platform data properly.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>

Applied.
