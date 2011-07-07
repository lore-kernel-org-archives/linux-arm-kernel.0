From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Jul 2011 14:20:03 -0400 (EDT)
Subject: [PATCH 07/52] ARM: mach-ep93xx: convert boot_params to atag_offset
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F383D6CF20@AUSP01VMBX24.collaborationhost.net>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<1309920457-21913-7-git-send-email-nicolas.pitre@linaro.org>
	<ADE657CA350FB648AAC2C43247A983F001F383D6CED9@AUSP01VMBX24.collaborationhost.net>
	<alpine.LFD.2.00.1107071247140.14596@xanadu.home>
	<ADE657CA350FB648AAC2C43247A983F001F383D6CF20@AUSP01VMBX24.collaborationhost.net>
Message-ID: <alpine.LFD.2.00.1107071411550.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, H Hartley Sweeten wrote:

> On Thursday, July 07, 2011 10:00 AM, Nicolas Pitre wrote:
> >> Other than that, for the ep93xx part.
> >> 
> >> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> >
> > Is this valid for both patches?
> 
> No. This patch only.
> 
> For patch 01/52 of this series, please fix the checkpatch.pl issue pointed
> out by Sergei Shtylyov and the build warning I pointed out.

Both were fixed.

> Once I see and test that updated patch I'll probably give you a Tested-by.

Due to the number of patches, I won't repost them unless a major change 
happens.  However you can see their latest incarnation here:

	http://git.linaro.org/gitweb?p=people/nico/linux.git;a=shortlog;h=refs/heads/redux

or pull them from here:

	git://git.linaro.org/people/nico/linux.git redux

Note that this branch is still going through frequent rebasing.


Nicolas
