From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 20 Apr 2011 15:40:03 +0200
Subject: [PATCH] pxa/hx4700: bq24022 regulator needs to be enabled
In-Reply-To: <BANLkTim_=pwuOvkRfMz_ZQe=NtJfGijajA@mail.gmail.com>
References: <E1QAkBF-0003bF-A0@outmx04.plus.net>
	<20110419084032.GA30743@rainbow> <20110419113201.GA32248@rainbow>
	<BANLkTim_=pwuOvkRfMz_ZQe=NtJfGijajA@mail.gmail.com>
Message-ID: <1303306804.2703.2.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 19.04.2011, 21:03 +0800 schrieb Eric Miao:
> On Tue, Apr 19, 2011 at 7:32 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> > On 12:40 Tue 19 Apr     , Dmitry Artamonow wrote:
> >> On 14:39 Fri 15 Apr     , Paul Parsons wrote:
> >> > Add REGULATOR_CHANGE_STATUS flag to hx4700 bq24022 regulator. Without this flag the bq24022 cannot be enabled and the battery will not charge.
> >> >
> >> Ah, so that's why my hx4700 doesn't charges under linux! I noticed
> >> that some time ago, but never found the time to investigate this.
> >> Thanks for finding this out. Will test.
> >
> > Yes, looks like it really works! After about an hour in linux-2.6.38 with
> > this patch applied, battery charged from about a half-empty to almost
> > full (I verified by rebooting into WinMobile). Good! And in dmesg there were
> > also "enabling charger" messages every time I plugged charger cable into
> > device.

Dito. Thank you, Paul!

> So, get my
> > Tested-by: Dmitry Artamonow <mad_soft@inbox.ru>
> 
> Thanks. Updated and pushed. Will send out git-pull soon.

Eric, if it's not too late, could you also apply the same fix for
magician?

cheers
Philipp
