From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Jul 2014 23:41:59 +0100
Subject: [PATCH v6 2/7] arm64: Introduce VA_BITS and translation level
 options
In-Reply-To: <53C43FE3.1050008@amd.com>
References: <000101cf6dc6$3b93d510$b2bb7f30$@samsung.com>
 <CAOZdJXWCu-zHuQoAUdiieqsKqCfG9BsZariFqQP=NCgQP-zpNA@mail.gmail.com>
 <53C43FE3.1050008@amd.com>
Message-ID: <20140714224159.GA9829@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 09:38:59PM +0100, Joel Schopp wrote:
> I agree that these patches would be very useful.  I just rebased my fix
> for a VTTBR_BADDR_MASK bug on one of these patches that could be pulled
> out independently.  See
> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010480.html
> 
> The original author Jungseok Lee is no longer available to work on
> future versions of these patches.  I was thinking that if they didn't
> get picked up as they are that with the original author's blessing I
> would pick them up and keep them forward ported/resubmitted.  I have an
> SOC to test them on.

The patches are pretty good. I'll give them a try tomorrow and if there
isn't something fundamental missing I'll consider taking them for 3.17.

-- 
Catalin
