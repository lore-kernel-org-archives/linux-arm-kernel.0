From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:27:56 -0800
Subject: [GIT PULL] ARM: dts: vexpress: fixes for v4.6
In-Reply-To: <56DF027E.3070807@arm.com>
References: <56DF027E.3070807@arm.com>
Message-ID: <20160313012756.GB5883@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 04:49:02PM +0000, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Sorry for the late pull request, but these DTC checks were introduced in
> -next last Friday. Please consider pulling this for v4.6
> 
> Regards,
> Sudeep
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/vexpress-for-v4.6/armv7-dt-updates
> 
> for you to fetch changes up to 929d755dbda796003a2eac981958def545efedf0:
> 
>   ARM: dts: vexpress: fix node name unit-address presence warnings
> (2016-03-08 14:52:34 +0000)
> 
> ----------------------------------------------------------------
> Update for ARM VExpress platforms
> 
> Just one update to fix node name unit-address presence/absence mismatch
> warnings in all the Vexpress device trees.

These kidn of changes can really wait until the next cycle when they
come in this late; there's already discussion on whether the dtc uprev
was the right thing to do or not at this time.

So, I'll hold off on this one since there's no other material in this branch.

-Olof
