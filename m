From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 Nov 2016 16:17:05 +0530
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <20161109182430.yh6uqeu2ufzkctww@rob-hp-laptop>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
 <20161109182430.yh6uqeu2ufzkctww@rob-hp-laptop>
Message-ID: <badc5b42-d1ed-6869-5dc4-92689ac2551f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 November 2016 11:54 PM, Rob Herring wrote:
> On Mon, Oct 31, 2016 at 03:45:34PM +0100, Bartosz Golaszewski wrote:
>> Create a new driver for the da8xx DDR2/mDDR controller and implement
>> support for writing to the Peripheral Bus Burst Priority Register.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to v4.10/drivers

Thanks,
Sekhar
