From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 16:38:00 +0530
Subject: [PATCH v7 3/5] drm: bridge: add support for TI ths8135
In-Reply-To: <dbb47a8f-07be-19d6-e77b-f5c06fd39c61@codeaurora.org>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
 <1481623759-12786-4-git-send-email-bgolaszewski@baylibre.com>
 <dbb47a8f-07be-19d6-e77b-f5c06fd39c61@codeaurora.org>
Message-ID: <0b47c27e-cda4-b5f6-ff3c-da74c40ed204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit,

On Wednesday 14 December 2016 10:35 AM, Archit Taneja wrote:
> 
> 
> On 12/13/2016 03:39 PM, Bartosz Golaszewski wrote:
>> THS8135 is a configurable video DAC, but no configuration is actually
>> necessary to make it work.
>>
>> For now use the dumb-vga-dac driver to support it.
> 
> Queued to drm-misc-next

This patch and 2/5 are not in v4.10 kernel. Did you mean to queue them
to v4.10?

Thanks,
Sekhar
