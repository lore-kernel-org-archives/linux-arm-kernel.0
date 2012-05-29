From: mturquette@ti.com (Mike Turquette)
Date: Tue, 29 May 2012 10:51:25 -0700
Subject: [RFC PATCH 09/11] ARM: OMAP4+: thermal: introduce bandgap
 temperature sensor
In-Reply-To: <4FC4CBC8.2040600@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
 <4FBFAA18.4040103@ti.com> <20120528111624.GC3923@besouro>
 <4FC4CBC8.2040600@ti.com>
Message-ID: <20120529175125.GD2722@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120529-15:14, Cousson, Benoit wrote:
> On 5/28/2012 1:16 PM, Eduardo Valentin wrote:
> >In fact I didn't touch the clk data on purpose and left the clock handling
> >as is. On my side I didn't know how the clock struct would look like with DT,
> >so, I didn't mess with it.
> >
> >Do you have a reference to check the work in progress for clock DT ?
> 
> Rob sent a pull request, it seems that now it is up to Mike T. :-)
> 
> http://lists-archives.com/linux-kernel/27640907-dt-clk-binding-support.html
> 

Due to the on-going discussion around those patches I haven't pulled
yet.  If everyone agrees once the dust settles then I'll take them in.

Regards,
Mike
