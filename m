From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 18 May 2016 11:56:38 -0700
Subject: [PATCH omap v2 0/6] Fix OMAP uses of RCU from idle loop
In-Reply-To: <573C7E6F.90001@roeck-us.net>
References: <20160516184844.GA20144@linux.vnet.ibm.com>
 <573C7E6F.90001@roeck-us.net>
Message-ID: <20160518185638.GD3528@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 07:38:39AM -0700, Guenter Roeck wrote:
> On 05/16/2016 11:48 AM, Paul E. McKenney wrote:
> >Hello!
> >
> >The following series fixes a number of uses of RCU from the idle loop.
> >These are all due to tracing, so the fix is simply to append _rcuidle
> >to the event-tracing call.
> >
> >Changes since v1: Fix commit-log subjects and add maintainers on CC.
> >
> 
> For the series, on top of mainline (which now experiences the problem fixed
> by this series):
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you!  And fixed the line-wrapping while I was at it.  ;-)

							Thanx, Paul
