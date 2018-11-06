From: tiny.windzz@gmail.com (Frank Lee)
Date: Tue, 6 Nov 2018 21:01:51 +0800
Subject: [PATCH v2] i2c: rk3x: fix some typo
In-Reply-To: <12637568.SqdzpTGmKQ@phil>
References: <20181102124535.24331-1-tiny.windzz@gmail.com>
 <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
 <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
 <12637568.SqdzpTGmKQ@phil>
Message-ID: <CAEExFWuP2yX9cFSjStosRZZ2aZOKGtekCg-u8UwqeM1909-Hwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko?

please?correct it in the cimmit message.

--Yangtao
On Tue, Nov 6, 2018 at 8:01 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Yangtao, Peter,
>
> Am Montag, 5. November 2018, 16:59:58 CET schrieb Frank Lee:
> > I am sorry.
> > -- Yangtao
>
> If anything, it is me that should be sorry, as I did suggest the
> patch description, including the new spelling error.
>
> And it took me like the whole weekend to actually realize where the
> Calculated / Calculates error was hiding ;-) .
>
>
> Heiko
>
> > On Fri, Nov 2, 2018 at 8:58 PM Peter Rosin <peda@axentia.se> wrote:
> > >
> > > On 2018-11-02 13:45, Yangtao Li wrote:
> > > > Fix multiple instances of a misspelled "Calculates".
> > >
> > > Yes, it sure is hard to spell "Calcluated," it's almost impossible to
> > > get it completely right and not introduce another typo somewhere... :-)
> > >
> > > Cheers,
> > > Peter
> > >
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > > Changes in v2:
> > > > -add commit message
> > > > ---
> > > >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> > > > index b8a2728dd4b6..fe347e8e2a23 100644
> > > > --- a/drivers/i2c/busses/i2c-rk3x.c
> > > > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > > > @@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
> > > >   *
> > > >   * @clk_rate: I2C input clock rate
> > > >   * @t: Known I2C timing information
> > > > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > > > + * @t_calc: Calculated rk3x private timings that would be written into regs
> > > >   *
> > > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> > > >   * a best-effort divider value is returned in divs. If the target rate is
> > > > @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
> > > >   *
> > > >   * @clk_rate: I2C input clock rate
> > > >   * @t: Known I2C timing information
> > > > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > > > + * @t_calc: Calculated rk3x private timings that would be written into regs
> > > >   *
> > > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> > > >   * a best-effort divider value is returned in divs. If the target rate is
> > > >
> > >
> >
>
>
>
>
