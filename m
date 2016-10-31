From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 31 Oct 2016 13:38:13 -0700
Subject: [PATCH v1 2/3] nvmem: Add the Broadcom OTP controller driver
In-Reply-To: <a85d1574-8d4b-e0bf-7340-7eab30deef37@broadcom.com>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
 <1477336324-10543-3-git-send-email-jonathan.richardson@broadcom.com>
 <f51e98c8-af71-5722-ab30-a27e176ddd5f@linaro.org>
 <a85d1574-8d4b-e0bf-7340-7eab30deef37@broadcom.com>
Message-ID: <66722267-425b-5d02-7612-8b5c57fd2f85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2016 12:55 PM, Scott Branden wrote:
> Florian,
> 
> On 16-10-31 07:23 AM, Srinivas Kandagatla wrote:
>>
>> On 24/10/16 20:12, Jonathan Richardson wrote:
>>> From: Jonathan Richardson <jonathar@broadcom.com>
>>>
>>> Add support for 32 and 64-bit versions of Broadcom's On-Chip OTP
>>> controller. These controllers are used on SoC's such as Cygnus and
>>> Stingray.
>>>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> Signed-off-by: Oza Pawandeep <oza@broadcom.com>
>>> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>>> ---
>>>  drivers/nvmem/Kconfig     |  12 ++
>>>  drivers/nvmem/Makefile    |   2 +
>>>  drivers/nvmem/bcm-ocotp.c | 335
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 349 insertions(+)
>>>  create mode 100644 drivers/nvmem/bcm-ocotp.c
>>
>>
>> I can pick this patch along with dt bindings document, but dts patch has
>> to go via arm-soc tree.
> 
> Can you pick up [PATCH v1 3/3] ARM: dts: Add node from Broadcom OTP
> controller driver?

As soon as we get Rob's acked-by for Patch 1, sure.
-- 
Florian
