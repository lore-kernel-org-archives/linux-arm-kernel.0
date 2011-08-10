From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Aug 2011 09:57:13 +0100
Subject: [RFC PATCH 4/8] ARM: exynos4: convert logical CPU numbers to
	physical numbers
In-Reply-To: <CAH9JG2WLfk2xECc3vObbVCPqqPE7W-PvvVJdOby7i8U8sXikPQ@mail.gmail.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
	<1312926162-22469-5-git-send-email-will.deacon@arm.com>
	<CAH9JG2WjHm2mypLR-9=1vNDz-h3PyRGwTP5Z-C1SsktRh+H6eA@mail.gmail.com>
	<20110810084613.GB10121@e102144-lin.cambridge.arm.com>
	<CAH9JG2WLfk2xECc3vObbVCPqqPE7W-PvvVJdOby7i8U8sXikPQ@mail.gmail.com>
Message-ID: <20110810085713.GC10121@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 09:49:45AM +0100, Kyungmin Park wrote:
> On Wed, Aug 10, 2011 at 5:46 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Aug 10, 2011 at 02:07:46AM +0100, Kyungmin Park wrote:
> >> Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > Cheers for that. Did you have a go at booting on a CPU other than physical
> > CPU 0?
> 
> No, how to test it?

Well, it depends on how your bootloader is configured. You want to throw
CPU1 at the kernel whilst putting CPU0 into the pen.

Of course, that might not be possible on your platform, but at least with
these patches it's not the core code getting in the way.

Will
