From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 17:34:04 +0200
Subject: [GIT PULL] i.MX fixes for 4.19, round 2
In-Reply-To: <20181003024815.GA4398@X250>
References: <20181001023923.GQ26692@dragon>
 <CAK8P3a1e8+HMwsFjE5AJW1E8M309dTkXHLqQb0Dne1gO_n61vg@mail.gmail.com>
 <f31c2fe8e753ba4c21e1c4b4ede270f88dddbf42.camel@pengutronix.de>
 <CAK8P3a0d3C3gDi_Ozh1gBTVXiAOc67_8SOYh7tzWVpP8trO8-A@mail.gmail.com>
 <20181003024815.GA4398@X250>
Message-ID: <CAK8P3a3vY631RJ-oHP6Jc5KDL5E0HeOeT-vj+bATmwL3bngu2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2018 at 4:48 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Oct 02, 2018 at 02:09:10PM +0200, Arnd Bergmann wrote:
> > Shawn, should I cherry-pick the other fix, or do you want to
> > follow up with a new pull request for the fixes?
>

> ----------------------------------------------------------------
> i.MX fixes for 4.19, round 2:
>  - i.MX53 QSB board stops working when cpufreq driver is enabled,
>    because the default OPP table has the maximum CPU frequency at
>    1.2GHz, while the board is only capable of running 1GHz.  Fix up
>    the OPP table for the board to get it work with cpufreq driver.
>
Pulled into fixes, thanks for respinning this!

      Arnd
