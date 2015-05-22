From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 22 May 2015 12:02:18 +0100
Subject: Hibernation on ARM64
In-Reply-To: <CAMxMOAtMw3jnyrvn46m0ZeiwtWjRRZ-i21N5+riwn-3qei+szg@mail.gmail.com>
References: <CAMxMOAtMw3jnyrvn46m0ZeiwtWjRRZ-i21N5+riwn-3qei+szg@mail.gmail.com>
Message-ID: <20150522110218.GC5623@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Thu, May 21, 2015 at 07:34:06PM +0100, Christian S. Perone wrote:
> Hello, I haven't found any information, road map or something like
> that for the hibernation support for ARM64, does anyone knows if there
> is something planned to support this in near future ?

Adding arch support for hibernation to arm64 should be fairly simple,
it is not top priority at the moment simply because there are not
compelling use-cases (on the PM side most features revolve around
CPUidle and suspend-to-idle and S2R).

To answer your question, yes I have planned to support it, I just
do not want to add it to the kernel for no particular reason, if there
are compelling requirements (I guess you are asking for a specific
reason) it can be done fairly quickly.

Thanks,
Lorenzo
