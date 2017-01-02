From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 16:46:11 +0530
Subject: [PATCH v7 4/5] ARM: dts: da850-lcdk: add the vga-bridge node
In-Reply-To: <0ad07b84-7f5a-6467-e310-52c3efc66d3d@ti.com>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
 <1481623759-12786-5-git-send-email-bgolaszewski@baylibre.com>
 <0ad07b84-7f5a-6467-e310-52c3efc66d3d@ti.com>
Message-ID: <0e2d1472-5200-915d-2b0c-ddfe7657bdd1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 December 2016 03:24 PM, Tomi Valkeinen wrote:
> On 13/12/16 12:09, Bartosz Golaszewski wrote:
>> Add the vga-bridge node to the board DT together with corresponding
>> ports and vga connector. This allows to retrieve the edid info from
>> the display automatically.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>>  arch/arm/boot/dts/da850-lcdk.dts | 51 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Applied to v4.11/dt with Tomi's reviewed-by.

Thanks,
Sekhar
