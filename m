From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 14:18:52 +0200
Subject: [PATCH 2/3] dt-bindings: reset: Add bindings for the Meson GXBB
 Reset Controller
In-Reply-To: <20160520090859.GB19888@mephisto>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-3-git-send-email-narmstrong@baylibre.com>
 <20160520084646.GB16732@mephisto> <573ED01C.2070800@baylibre.com>
 <20160520090859.GB19888@mephisto>
Message-ID: <573F00AC.6040304@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2016 11:08 AM, Carlo Caione wrote:
> On 20/05/16 10:51, Neil Armstrong wrote:
>> On 05/20/2016 10:46 AM, Carlo Caione wrote:
>>> On 20/05/16 10:27, Neil Armstrong wrote:
>>>> Add DT bindings for the Meson GXBB SoC Reset Controller documentation and the
>>>> associated include file.
>>>
>>> [...]
>>>
>>>> +#define RESET_I2C_MASTER_2	142
>>>> +#define RESET_I2C_MASTER_1	143
>>>> +/*				144-159	*/
>>>> +/*	RESET5				*/
>>>> +/*				160-191	*/
>>>> +/*	RESET6				*/
>>>> +#define RESET_PERIPHS_GENERAL	192
>>>> +#define RESET_PERIPHS_SPICC	193
>>>> +#define RESET_PERIPHS_SMART_CARD	194
>>>> +#define RESET_PERIPHS_SAR_ADC	195
>>>> +#define RESET_PERIPHS_I2C_MASTER_0	196
>>>> +#define RESET_SANA		197
>>>> +/*				198	*/
>>>> +#define RESET_PERIPHS_STREAM_INTERFACE	199
>>>> +#define RESET_PERIPHS_SDIO	200
>>>> +#define RESET_PERIPHS_UART_0	201
>>>> +#define RESET_PERIPHS_UART_1_2	202
>>>> +#define RESET_PERIPHS_ASYNC_0	203
>>>> +#define RESET_PERIPHS_ASYNC_1	204
>>>> +#define RESET_PERIPHS_SPI_0	205
>>>> +#define RESET_PERIPHS_SDHC	206
>>>> +#define RESET_UART_SLIP		207
>>>> +/*				208-223	*/
>>>> +/*	RESET7				*/
>>>> +#define RESET_USB_DDR_0		224
>>>> +#define RESET_USB_DDR_1		225
>>>> +#define RESET_USB_DDR_2		226
>>>> +#define RESET_USB_DDR_3		227
>>>> +/*				228	*/
>>>> +#define RESET_DEVICE_MMC_ARB	229
>>>> +/*				230	*/
>>>> +#define RESET_VID_LOCK		231
>>>> +#define RESET_A9_DMC_PIPEL	232
>>>> +/*				233-255	*/
>>>> +
>>>> +#endif
>>>
>>> Indentation looks really messy. Can you just shift the numbers to the
>>> right so that they are on the same column?
>>>
>> Hi Carlo,
>>
>> The patch format makes it very messy, not as in the original format :
>> https://github.com/superna9999/linux/blob/6163f8742454bb7ff962956b4e286d110ec0fb79/include/dt-bindings/reset/amlogic%2Cmeson-gxbb-reset.h
> 
> https://raw.githubusercontent.com/superna9999/linux/6163f8742454bb7ff962956b4e286d110ec0fb79/include/dt-bindings/reset/amlogic%2Cmeson-gxbb-reset.h
> 
> yes, but 192 -> 200 are not nicely indented to me :)
> 

Aw, you got me !

I will add a shift and add a separate meson8b version of this file.

Neil
