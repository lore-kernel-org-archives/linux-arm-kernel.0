From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 May 2012 12:56:10 +0200
Subject: [PATCH v2] ARM: at91: add atmel-mci support for chips and boards
 which can use it
In-Reply-To: <20120528074133.GR3377@game.jcrosoft.org>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
 <20120528074133.GR3377@game.jcrosoft.org>
Message-ID: <4FC4AB4A.8060605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2012 09:41 AM, Jean-Christophe PLAGNIOL-VILLARD :
> On 12:23 Mon 21 May     , ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
>> use it instead of at91_mci driver.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> ---
>> V2: add several boards I missed
> for the 9g20 and 9260 please drop the old driver support too

No, we will drop the support for old driver when we finish the
transition period. We will then drop at91_mci with all configuration
data in device/board files.

> for calao bord you can do it too

Well, you can add it yourself. As you may be able to test it, it sounds
better if you handle this part...

Bye,
-- 
Nicolas Ferre
