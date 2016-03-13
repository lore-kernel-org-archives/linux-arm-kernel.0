From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:20:53 -0800
Subject: [GIT PULL] arm64: dts: vexpress/juno: Updates for v4.6(part 2)
In-Reply-To: <56DF0274.1060007@arm.com>
References: <56DF0274.1060007@arm.com>
Message-ID: <20160313012053.GA24249@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 04:48:52PM +0000, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Sorry for the late pull request.
> 
> There's one update for adding support for SBSA Watchdog to foundation
> model that caused conflict as it was merged via watchdog tree. I am
> pulling that now to avoid conflicts and I also have a patch to fix DT
> warnings that new checks in DTS introduced since last Friday. Please
> consider pulling this for v4.6
> 
> Regards,
> Sudeep
> 
> 
> The following changes since commit 9fd9288ed0899f9e318a97d73e777d6d3357265e:
> 
>   arm64: dts: Add HDLCD support on Juno platforms (2016-02-10 10:58:33
> +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/vexpress-for-v4.6/dt-updates-2
> 
> for you to fetch changes up to 6d6acd140ab3d46348ec3a9dbfd386d9ca42b825:
> 
>   arm64: dts: juno/vexpress: fix node name unit-address presence warnings
> (2016-03-08 13:54:27 +0000)
> 
> ----------------------------------------------------------------
> Additional updates for ARM VExpress/Juno platforms
> 
> 1. Add support for SBSA Generic Watchdog on foundation models
> 
> 2. Fix node name unit-address presence/absence mismatch warnings in
>    all the device trees
> 
> ----------------------------------------------------------------
> Fu Wei (1):
>       arm64: dts: foundation-v8: add SBSA Generic Watchdog device node
> 
> Sudeep Holla (1):
>       arm64: dts: juno/vexpress: fix node name unit-address presence
> warnings

Merged, thanks.


-Olof
