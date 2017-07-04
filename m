From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 4 Jul 2017 12:15:36 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170703150733.sop6yrrpfl3ne32g@sirena.org.uk>
References: <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
 <20170630051203.GY29665@vireshk-i7>
 <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
 <20170630084330.GB29665@vireshk-i7>
 <20170630121026.azppihjqls5i6bbr@sirena.org.uk>
 <20170703061552.GB3532@vireshk-i7>
 <20170703150733.sop6yrrpfl3ne32g@sirena.org.uk>
Message-ID: <20170704064536.GG3532@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-07-17, 16:07, Mark Brown wrote:
> On Mon, Jul 03, 2017 at 11:45:52AM +0530, Viresh Kumar wrote:
> > The above regulator-min/max-microvolt values I mentioned were for the regulator
> > device and not what the consumers would request. Yes, DMA will request something
> 
> If you're putting the maximum possible range that the physical regulator
> can supply into machine constraints then you really haven't understood
> what machine constraints are at all.

I wasn't referring to the limits of the physical regulators but the min/max that
the consumers can set on a particular platform.

> No, it really shouldn't.  Please read what I wrote.

Sorry about that. Understood it now.

-- 
viresh
