From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 9 Nov 2016 10:43:30 -0800
Subject: [PATCH v2 2/2] mmc: sdhci-iproc: support standard byte register
 accesses
In-Reply-To: <132c772b-d4b9-c4b6-2eca-0393e7c995f9@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
 <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
 <c94dc018-5a2d-d50b-5746-43ae7fc258ce@intel.com>
 <132c772b-d4b9-c4b6-2eca-0393e7c995f9@broadcom.com>
Message-ID: <f0e972d9-145c-e87d-f365-da74d6222679@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian/Ulf,

Please ignore my comments in last email I sent out.  The v2 patch 
documentation matches the code and is good.  I am confusing myself 
between internal versions and external upstream versions of this code.

On 16-11-09 10:38 AM, Scott Branden wrote:
> Hi Adrian/Ulf,
>
> On 16-11-08 01:55 AM, Adrian Hunter wrote:
>> On 01/11/16 18:37, Scott Branden wrote:
>>> Add bytewise register accesses support for newer versions of IPROC
>>> SDHCI controllers.
>>> Previous sdhci-iproc versions of SDIO controllers
>>> (such as Raspberry Pi and Cygnus) only allowed for 32-bit register
>>> accesses.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> This is unchanged from V1 which I acked, so:
> I updated the binding name in the documentation but forgot to change it
> in this patch.  Now that Rob has ack'd the binding documentation I will
> send out an updated patch with binding string in the code matching the
> ack'd documentation.
Ignore this - PATCH v2 is good.
>
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
> With the minor change I will add your ack to the next version I send out.
>
> Thanks,
>  Scott
