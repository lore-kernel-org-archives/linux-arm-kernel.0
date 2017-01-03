From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 3 Jan 2017 11:08:51 +0530
Subject: [PATCH v7 3/5] drm: bridge: add support for TI ths8135
In-Reply-To: <da6d299e-be36-7564-f57f-ba5e3601cafc@codeaurora.org>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
 <1481623759-12786-4-git-send-email-bgolaszewski@baylibre.com>
 <dbb47a8f-07be-19d6-e77b-f5c06fd39c61@codeaurora.org>
 <0b47c27e-cda4-b5f6-ff3c-da74c40ed204@ti.com>
 <da6d299e-be36-7564-f57f-ba5e3601cafc@codeaurora.org>
Message-ID: <d550a8e6-9939-aa5c-8c8c-938dd2290552@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 January 2017 10:56 AM, Archit Taneja wrote:
> Hi Sekhar,
> 
> On 1/2/2017 4:38 PM, Sekhar Nori wrote:
>> Hi Archit,
>>
>> On Wednesday 14 December 2016 10:35 AM, Archit Taneja wrote:
>>>
>>>
>>> On 12/13/2016 03:39 PM, Bartosz Golaszewski wrote:
>>>> THS8135 is a configurable video DAC, but no configuration is actually
>>>> necessary to make it work.
>>>>
>>>> For now use the dumb-vga-dac driver to support it.
>>>
>>> Queued to drm-misc-next
>>
>> This patch and 2/5 are not in v4.10 kernel. Did you mean to queue them
>> to v4.10?
> 
> These missed out on 4.10 because the drm related pull requests were
> already sent by then. These 2 patches are queued for 4.11.

Alright, thanks for the update.

Regards,
Sekhar
