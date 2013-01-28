From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 22:47:57 -0800
Subject: [GIT PULL] psci client-side implementation for 3.9
In-Reply-To: <20130123180507.GH26811@mudshark.cambridge.arm.com>
References: <20130123180507.GH26811@mudshark.cambridge.arm.com>
Message-ID: <20130128064757.GF25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 06:05:07PM +0000, Will Deacon wrote:
> Hello again guys,
> 
> Please pull my PSCI client-side implementation for 3.9. This is used by
> the mach-virt platform, for which I'll send another pull request later
> on (since there are some timer dependencies that need resolving first).
> 
> As before, I'll keep this branch stable so others can base against it.
> 
> Thanks,
> 
> Will
> 
> --->8
> 
> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
> 
>   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/virt/psci

Thanks, added as depends/rmk-psci in arm-soc, just as rmk-perf I have not
actually merged it in with anything yet though.


-Olof
