From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 17:58:12 +0000
Subject: [PATCH v2 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <20171201175026.GB8826@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <20171201140406.oanuaz6zvyrhp4ml@lakrids.cambridge.arm.com>
 <20171201175026.GB8826@arm.com>
Message-ID: <20171201175812.n6ht7h52j3z4pgw2@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 05:50:26PM +0000, Will Deacon wrote:
> On Fri, Dec 01, 2017 at 02:04:06PM +0000, Mark Rutland wrote:
> > On Thu, Nov 30, 2017 at 04:39:28PM +0000, Will Deacon wrote:
> Thanks for going through this. Do you have any ideas about what we could
> rename the command-line option to? I'll get us started:
> 
>   - kaiser=
>   - hidekernel=
>   - unmapkernel=
>   - hardenkaslr=
>   - swuan=

Off all of these, I think "unmapkernel" is the clear winner, since it
says what it does in the tin (even if it misses the when).

I'll have a think over the weekend.

Thanks,
Mark.
