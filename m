From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:24:15 +0200
Subject: [PATCH] ARM/EP93xx/timer: Migrate to new 'set-state' interface
In-Reply-To: <BN3PR0101MB10579524DEE61E49B8725469D07E0@BN3PR0101MB1057.prod.exchangelabs.com>
References: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
 <BN3PR0101MB10579524DEE61E49B8725469D07E0@BN3PR0101MB1057.prod.exchangelabs.com>
Message-ID: <20150813092415.GE30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 04:39:46PM +0000, Hartley Sweeten wrote:
> On Thursday, August 06, 2015 2:11 AM, Viresh Kumar wrote:
> > Migrate EP93xx driver to the new 'set-state' interface provided by
> > clockevents core, the earlier 'set-mode' interface is marked obsolete
> > now.
> >
> > This also enables us to implement callbacks for new states of clockevent
> > devices, for example: ONESHOT_STOPPED.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks, applied now.


-Olof
