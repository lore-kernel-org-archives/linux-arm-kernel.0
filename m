From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Jul 2012 16:14:47 +0100
Subject: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
In-Reply-To: <50115F3F.7050705@ti.com>
References: <4FD7B1DC.30108@ti.com>
 <20120612213150.GC24380@mudshark.cambridge.arm.com>
 <4FD7C597.7060501@ti.com>
 <20120702095539.GD22239@mudshark.cambridge.arm.com>
 <4FF1D15E.7040301@ti.com>
 <20120702220117.GD25234@mudshark.cambridge.arm.com>
 <4FF6340A.6020409@ti.com> <50109233.3090302@ti.com>
 <20120726150534.GD6382@mudshark.cambridge.arm.com>
 <50115F3F.7050705@ti.com>
Message-ID: <20120731151446.GK3903@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:16:15PM +0100, Jon Hunter wrote:
> On 07/26/2012 10:05 AM, Will Deacon wrote:
> > Ok, thanks for updating me. I've pushed the patches out onto my
> > perf/omap4-dev branch as that seems to be a good place to collate the
> > current state of things. I've not tried doing anything with it yet though.
> 
> Ok, great. Let me know if you have any problems. I have ran some initial
> testing on omap3430, omap4430 and omap4460 and it seems ok (AFAICT).

Just an FYI that I gave up maintaining the old perf/omap4 branch and instead
moved everything from perf/omap4-dev onto that as the rebase was getting
painful.

Will
