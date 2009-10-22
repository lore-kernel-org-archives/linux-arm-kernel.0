From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 22 Oct 2009 14:49:57 -0700
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <19160.60691.72229.932486@pilspetsen.it.uu.se>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
Message-ID: <e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikael,

On Fri, Oct 16, 2009 at 3:00 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> This adds a better sched_clock() to the IOP platform,
> implemented using its new clocksource support.
>
> Tested on n2100, compile-tested for all plat-iop machines.
>
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---

I applied this series and my iop13xx does not get past "Uncompressing
Linux".  Bisecting points to this patch i.e. the other three are ok
(at least for booting).  Any ideas?  I won't have time to debug this
for a while.

Regards,
Dan
