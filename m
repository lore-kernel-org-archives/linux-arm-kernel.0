From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 13:27:25 -0700
Subject: [PATCH 2/2] arm/dts: Cleanup regulator naming and remove @0,1..
In-Reply-To: <1343653940-16614-3-git-send-email-rnayak@ti.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-3-git-send-email-rnayak@ti.com>
Message-ID: <20120824202725.GA1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120730 06:17]:
> regulators do not have a 'reg' property, hence the regulator at 0,
> regulator at 1 do not make sense. get rid of it.

Looks like this needs to be refreshed to apply. Care to
refresh against current devel-dt branch in case other
places need the same change?

Regards,

Tony
