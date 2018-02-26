From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 26 Feb 2018 11:25:54 +0530
Subject: [PATCH] ARM: dts: da850-lego-ev3: use a correct fallback for at24
 compatible
In-Reply-To: <c4c07714-4937-48bd-466d-c2c9848c4725@lechnology.com>
References: <20180122125505.16806-1-brgl@bgdev.pl>
 <c4c07714-4937-48bd-466d-c2c9848c4725@lechnology.com>
Message-ID: <134fc583-785c-0112-94f2-f94b9ff93065@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 January 2018 10:20 PM, David Lechner wrote:
> On 01/22/2018 06:55 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We now require all at24 users to use the "atmel,<model>" fallback in
>> device tree for different manufacturers.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

Applied to v4.17/dt

Thanks,
Sekhar
