From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 29 Apr 2014 07:38:33 -0700
Subject: [PATCH v2 00/10] arm64: UEFI support
In-Reply-To: <20140429134726.GH17007@arm.com>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <20140429102817.GE17007@arm.com> <20140429114356.GK26088@console-pimps.org>
 <20140429134726.GH17007@arm.com>
Message-ID: <535FB969.5080503@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 06:47 AM, Catalin Marinas wrote:
> 
> Waiting for the tip/x86/efi to be merged first is not a problem. We
> also need a stable base for testing the arm64 UEFI series, so I assume
> this series can be based onto tip/x86/efi (would such branch be rebased
> before hitting mainline?).
> 
> Given that Leif's series contains both generic efi and arm64 patches,
> what's your preference for merging them? I'm happy to add my ack and
> they go via your tree (or the other way around).
> 

tip:x86/efi will not be rebased (barring major unforseen events).

I'm not opposed to pushing the arm64 patches through -tip (via Matt), if
it works with your workflow, either.  Perhaps we need to rename the
branch to tip:core/efi...

	-hpa
