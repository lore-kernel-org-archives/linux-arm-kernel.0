From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 01 Aug 2011 16:19:52 +0100
Subject: [RFC PATCH 1/9] mmc: atmel-mci: change namespace
In-Reply-To: <20110730074807.GH25658@game.jcrosoft.org>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
	<1311863398-31579-2-git-send-email-ludovic.desroches@atmel.com>
	<20110730074807.GH25658@game.jcrosoft.org>
Message-ID: <4E36C418.1060604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2011 08:48 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:29 Thu 28 Jul     , ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>
>> Homogenize namespace to atmci.
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
> prefer ATMEL_MCI
>
> ATMCI is not clear

Well it is used all over the place in the driver code. It is shorter and 
in coherence with what is existing already: I will take ATMCI_ naming by 
Ludovic.

Best regards,
-- 
Nicolas Ferre
