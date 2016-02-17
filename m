From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Feb 2016 17:26:00 +0000
Subject: [PATCH 4/4] arm64: cputype info for Broadcom Vulcan
In-Reply-To: <56C3C9D4.4020506@gmail.com>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
 <1455389195-31870-5-git-send-email-jchandra@broadcom.com>
 <20160215101235.GA1748@arm.com> <56C3C9D4.4020506@gmail.com>
Message-ID: <20160217172600.GA26514@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 05:16:04PM -0800, Florian Fainelli wrote:
> On 15/02/16 02:12, Will Deacon wrote:
> > On Sun, Feb 14, 2016 at 12:16:35AM +0530, Jayachandran C wrote:
> >> Add Broadcom Vulcan implementor ID and part ID in cputype.h. This is
> >> to document the values.
> >>
> >> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> >> ---
> >>  arch/arm64/include/asm/cputype.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Would this be picked by Calatin, or should this be sent along with the
> ARM/ARM64 SoC changes pull requests (just wondering?), thanks!

It can go via the arm-soc tree together with the other patches. If you
need another ack:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
