From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 Nov 2016 16:17:22 +0530
Subject: [PATCH v2 2/5] ARM: bus: da8xx-mstpri: new driver
In-Reply-To: <20161109182433.vskk5rn7hfxshfy6@rob-hp-laptop>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-3-git-send-email-bgolaszewski@baylibre.com>
 <20161109182433.vskk5rn7hfxshfy6@rob-hp-laptop>
Message-ID: <dbf9924b-1d00-1c9d-192e-927f9bbe58c2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 November 2016 11:54 PM, Rob Herring wrote:
> On Mon, Oct 31, 2016 at 03:45:35PM +0100, Bartosz Golaszewski wrote:
>> Create the driver for the da8xx master peripheral priority
>> configuration and implement support for writing to the three
>> Master Priority registers on da850 SoCs.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  .../devicetree/bindings/bus/ti,da850-mstpri.txt    |  20 ++
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to v4.10/drivers

Thanks,
Sekhar
