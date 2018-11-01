From: tiny.windzz@gmail.com (Frank Lee)
Date: Fri, 2 Nov 2018 00:18:46 +0800
Subject: [PATCH] i2c: rk3x: fix some typo
In-Reply-To: <5544442.bXqbKBZQMR@diego>
References: <20181101153749.22935-1-tiny.windzz@gmail.com>
 <5544442.bXqbKBZQMR@diego>
Message-ID: <CAEExFWsO=piLg_JCCKTH6p49f+RT8qDzii6iwjHuTcwd8j0Okw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Hi,
>
>Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
>while the changes really are pretty self-explanatory, it is always
>nice to describe changes in a real commit message, like
>
>Fix multiple instances of a misspelled "Calculates".
>
>Change itself looks good, so
>Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
>Thanks

Yeah,this is my fault.

--Yangtao Li
On Thu, Nov 1, 2018 at 11:56 PM Heiko St?bner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> while the changes really are pretty self-explanatory, it is always
> nice to describe changes in a real commit message, like
>
> Fix multiple instances of a misspelled "Calculates".
>
> Change itself looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
> Thanks
> Heiko
>
> > ---
> >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> > index b8a2728dd4b6..fe347e8e2a23 100644
> > --- a/drivers/i2c/busses/i2c-rk3x.c
> > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > @@ -555,7 +555,7 @@ static const struct i2c_spec_values
> > *rk3x_i2c_get_spec(unsigned int speed) *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > + * @t_calc: Calculated rk3x private timings that would be written into regs
> > *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that
> > case * a best-effort divider value is returned in divs. If the target rate
> > is @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long
> > clk_rate, *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > + * @t_calc: Calculated rk3x private timings that would be written into regs
> > *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that
> > case * a best-effort divider value is returned in divs. If the target rate
> > is
>
>
>
>
