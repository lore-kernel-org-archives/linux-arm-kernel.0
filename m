From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 11 Aug 2018 12:44:02 +0300
Subject: [PATCH v2] media: i2c: lm3560: use conservative defaults
In-Reply-To: <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
References: <20180506080250.GA24114@amd> <20180716090814.GA4505@amd>
 <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
Message-ID: <CAHp75Vf4PZW8A+uj8V5uL2LkTSzSogQDcR8JTqVh4jzVecgtRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2018 at 9:10 AM, Daniel Jeong <gshark.jeong@gmail.com> wrote:
> Hi Pavel,
>
> I think if there is not exist pdata, it should be set to the value of power
> on reset (POR) to sync with the chip.
>
> According to the LM3560 datasheet, Flash Timeout is 512ms, Flash current is
> 875mA and Torch Current is 93.75mA.

Can't we simple read back?

-- 
With Best Regards,
Andy Shevchenko
