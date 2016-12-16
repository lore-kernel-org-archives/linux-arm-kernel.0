From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Dec 2016 16:57:12 +0000
Subject: [PATCH] arm: dt: Initialize boot_command_line from
 CONFIG_CMDLINE in case DT does not provide /chosen/bootargs
In-Reply-To: <20161216154029.GF4920@atomide.com>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <201612161332.36406@pali>
 <5c56e769-76be-295e-b655-8431dde35370@osg.samsung.com>
 <201612161348.35917@pali>
 <1b779429-8ce4-a49b-38e4-573b28a7c05f@osg.samsung.com>
 <20161216154029.GF4920@atomide.com>
Message-ID: <20161216165711.GG20265@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 07:40:30AM -0800, Tony Lindgren wrote:
> Yeah probaby best to add the empty chosen node to the ones that had
> skeleton.dtsi removed.

Yes please!

We should probably update the comment in skeleton.dtsi to be more
explicit. I had intended it to mean that chosen should always be
present in the dts, but I worded it poorly.

Thanks,
Mark.
