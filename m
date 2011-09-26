From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 26 Sep 2011 11:22:08 +0200
Subject: [PATCH v3 2/2] at91: add Atmel ISI and ov2640 support on
	sam9m10/sam9g45 board.
In-Reply-To: <20110924052609.GI29998@game.jcrosoft.org>
References: <1316664661-11383-1-git-send-email-josh.wu@atmel.com>
	<1316664661-11383-2-git-send-email-josh.wu@atmel.com>
	<Pine.LNX.4.64.1109220911500.11164@axis700.grange>
	<20110924052609.GI29998@game.jcrosoft.org>
Message-ID: <4E804440.7030709@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/09/2011 07:26, Jean-Christophe PLAGNIOL-VILLARD :
> On 09:35 Thu 22 Sep     , Guennadi Liakhovetski wrote:
>> On Thu, 22 Sep 2011, Josh Wu wrote:
>>
>>> This patch
>>> 1. add ISI_MCK parent setting code when add ISI device.
>>> 2. add ov2640 support on board file.
>>> 3. define isi_mck clock in sam9g45 chip file.
>>>
>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>> ---
>>>  arch/arm/mach-at91/at91sam9g45.c         |    3 +
>>>  arch/arm/mach-at91/at91sam9g45_devices.c |  105 +++++++++++++++++++++++++++++-
>>>  arch/arm/mach-at91/board-sam9m10g45ek.c  |   85 ++++++++++++++++++++++++-
>>>  arch/arm/mach-at91/include/mach/board.h  |    3 +-
>>
>> Personally, I think, it would be better to separate this into two patches 
>> at least: one for at91 core and one for the specific board, but that's up 
>> to arch maintainers to decide.
>>
>> You also want to patch arch/arm/mach-at91/at91sam9263_devices.c, don't 
>> you?
> agreed

No, I am not sure. The IP is not the same between 9263 and 9g45/9m10. So
this inclusion will not apply.

Best regards,
-- 
Nicolas Ferre
