From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 19 May 2015 12:45:00 +0300
Subject: [PATCH v3 06/17] video: lcd: add LoCoMo LCD driver
In-Reply-To: <20150519093644.GT22418@x1>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
 <1431880077-26321-7-git-send-email-dbaryshkov@gmail.com>
 <20150519093644.GT22418@x1>
Message-ID: <CALT56yMwGngNvRWiCux962B=EQODUHW3=-ed6SZWJ9PnSPm09A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 12:36 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> On Sun, 17 May 2015, Dmitry Eremin-Solenikov wrote:
>
>> LoCoMo has some special handling for TFT screens attached to Collie and
>> Poodle. Implement that as a separate driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  drivers/video/backlight/Kconfig      |  10 ++
>>  drivers/video/backlight/Makefile     |   1 +
>>  drivers/video/backlight/locomo_lcd.c | 285 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 296 insertions(+)
>>  create mode 100644 drivers/video/backlight/locomo_lcd.c
>
> This looks like it should be part of patch 16.
>
> How much of this file is the same as the one removed later in the set?

This is a completely new driver. Only few comments remained from old
locomolcd.c.

-- 
With best wishes
Dmitry
