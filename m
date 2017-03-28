From: jsarha@ti.com (Jyri Sarha)
Date: Tue, 28 Mar 2017 16:32:34 +0300
Subject: [PATCH 1/2] drm/bridge: ti-tfp410: support hpd via gpio
In-Reply-To: <d6b2391f-3e4a-2761-b6a0-8997d2c78600@codeaurora.org>
References: <2e47786ab3d04078ae70d0c4064f7c4d@rwthex-s1-b.rwth-ad.de>
 <093b4e9c0ae6413499e5bf8ec309fa41@rwthex-s1-b.rwth-ad.de>
 <6dfb2b66ec2a408dabe80d703f411ce0@rwthex-s1-b.rwth-ad.de>
 <d6b2391f-3e4a-2761-b6a0-8997d2c78600@codeaurora.org>
Message-ID: <f87195b3-bd89-d698-c935-4e3aa97c01e2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/17 08:58, Archit Taneja wrote:
> Hi,
> 
> On 03/07/2017 03:21 AM, Christopher Spinrath wrote:
>> Hi Fabio,
>>
>> On 03/06/2017 10:46 PM, Fabio Estevam wrote:
>>> Hi Christopher,
>>>
>>> On Mon, Mar 6, 2017 at 6:40 PM, 
>>> <christopher.spinrath@rwth-aachen.de> wrote:
>>>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>>>
>>>> On some boards the hpd pin of a hdmi connector is wired up to a gpio
>>>> pin. Since in the DRM world the tfp410 driver is responsible for
>>>> handling the connector, add support for hpd gpios in this very driver.
>>>>
>>>> Signed-off-by: Christopher Spinrath
>>>> <christopher.spinrath@rwth-aachen.de>
>>>> ---
>>>>  drivers/gpu/drm/bridge/ti-tfp410.c | 72
>>>> ++++++++++++++++++++++++++++++++++++--
>>>
...
>>
> 
> The patch looks good to me.
> 
> Jyri,
> 
> Is it possible for you to verify this on Beaglebone platform?
> 

If I read my BeagleBone DVI-D Cape docs right, it does not have the HPD
pin connected. At least it does not mention any gpio that could be used
for the purpose. So I can not easily test this patch in real world
situation. For what it is worth the patch looks ok to me too.

Best regards,
Jyri
