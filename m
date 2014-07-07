From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 07 Jul 2014 08:57:41 +0200
Subject: [PATCH v7 23/24] rtc: Add driver for Maxim 77802 PMIC
 Real-Time-Clock
In-Reply-To: <1404713210.4367.0.camel@AMDC1943>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-24-git-send-email-javier.martinez@collabora.co.uk>
 <1404713210.4367.0.camel@AMDC1943>
Message-ID: <53BA44E5.6070604@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 07/07/2014 08:06 AM, Krzysztof Kozlowski wrote:
> On pi?, 2014-07-04 at 22:24 +0200, Javier Martinez Canillas wrote:
>> The MAX7802 PMIC has a Real-Time-Clock (RTC) with two alarms.
>> This patch adds support for the RTC and is based on a driver
>> added by Simon Glass to the Chrome OS kernel 3.8 tree.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> 
>> Changes since v6:
>>  - Remove unused code for SMPL and WTSR. Suggested by Krzysztof Kozlowski.
>>  - Don't spam the kernel log with unimportant info and just print for debug.
>>    Suggested by Krzysztof Kozlowski.
>>  - Use ARRAY_SIZE() instead of constant value. Suggested by Krzysztof Kozlowski.
>>  - Remove duplicated register setup. Suggested by Krzysztof Kozlowski.
>>  - Don't free/unregister managed allocated resources.
>>    Suggested by Krzysztof Kozlowski.
>> ---
>>  drivers/rtc/Kconfig        |  10 +
>>  drivers/rtc/Makefile       |   1 +
>>  drivers/rtc/rtc-max77802.c | 508 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 519 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-max77802.c
> 
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Thanks a lot for the review and for all the feedback you gave me on each version
of the series.

> Best regards,
> Krzysztof
> 
> 

Best regards,
Javier
