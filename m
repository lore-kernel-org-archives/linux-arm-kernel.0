From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 16 Jul 2014 18:16:54 +0800
Subject: [PATCH v2 1/3] mtd: atmel_nand: add NFC status error check
In-Reply-To: <53C64EA2.3050703@atmel.com>
References: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
 <53C64EA2.3050703@atmel.com>
Message-ID: <53C65116.2040508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/16/2014 6:06 PM, Josh Wu wrote:
> On 6/10/2014 5:50 PM, Josh Wu wrote:
>> Add a new function to read the NFC status. Meantime, this function will
>> theck if there is any errors in NFC.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>
> Tested-by: Matthieu Crapet <Matthieu.Crapet@ingenico.com>
>

Sorry, I forgot to mention this Tested-by tag is for these patch series.

Best Regards,
Josh Wu

> I add a Tested-by tag from Matthieu Crapet.
> He didn't reply this email thread directly. His test-by tag is in 
> email:http://lists.infradead.org/pipermail/linux-mtd/2014-June/054443.html 
>
>
> Best Regards,
> Josh Wu
>
