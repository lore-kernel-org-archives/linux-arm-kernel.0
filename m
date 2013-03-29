From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Mar 2013 17:01:43 +0530
Subject: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
In-Reply-To: <515579C6.1090602@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
 <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org>
 <515572C7.1030309@ti.com> <515579C6.1090602@linaro.org>
Message-ID: <51557B9F.7090608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 04:53 PM, Daniel Lezcano wrote:
> On 03/29/2013 11:53 AM, Santosh Shilimkar wrote:
>> On Friday 29 March 2013 04:15 PM, Daniel Lezcano wrote:
[..]

> For OMAP3 that could be a bit more difficult. Who is maintaining the
> driver now ?
> 
The driver is still maintained by Kevin Hilman and quite a few us keep
that driver upto date. OMAP3 idle is movable as well. A while back I
have assessed move of OMAP3 and OMAP4 idle drivers, and the only issue
was the other PRM/CM dependency.

Regards,
Santosh
