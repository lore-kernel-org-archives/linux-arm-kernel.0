From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Jan 2017 13:06:23 +0800
Subject: [PATCH v2 19/25] iio: adc: axp20x_adc: map battery IIO channels
In-Reply-To: <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-20-quentin.schulz@free-electrons.com>
 <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
Message-ID: <CAGb2v6662oikMk8uhD-mMx9d4Gf4Fw64ndOsj89EPcNxA9S6Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 10:52 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/01/17 08:54, Quentin Schulz wrote:
>> This maps the IIO channels batt_v, batt_chrg_i and batt_dischrg_i
>> (respectively exposing the current charging and discharging currents and
>> current voltage measures of the battery power supply) to the battery
>> power supply driver.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
