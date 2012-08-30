From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2012 13:48:26 -0700
Subject: [PATCH 2/2] arm/dts: Cleanup regulator naming and remove @0,1..
In-Reply-To: <503C6380.4090107@ti.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-3-git-send-email-rnayak@ti.com>
 <20120824202725.GA1303@atomide.com> <503C6380.4090107@ti.com>
Message-ID: <20120830204825.GE1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120827 23:22]:
> Hi Tony,
> 
> >* Rajendra Nayak<rnayak@ti.com>  [120730 06:17]:
> >>regulators do not have a 'reg' property, hence the regulator at 0,
> >>regulator at 1 do not make sense. get rid of it.
> >
> >Looks like this needs to be refreshed to apply. Care to
> >refresh against current devel-dt branch in case other
> >places need the same change?
> 
> Looks like devel-dt is missing the PATCH 1/2 from this series,
> which you have already pushed in the -rc for merge.
> With that applied, this ones applies cleanly too.

Oh OK thanks :) I'll apply it on top of the fix and merge
into devel-dt.

Tony
