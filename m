From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 13:55:06 -0700
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.13 (last round)
In-Reply-To: <20131023113237.GG24520@titan.lakedaemon.net>
References: <20131023113237.GG24520@titan.lakedaemon.net>
Message-ID: <20131028205506.GD4802@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 07:32:37AM -0400, Jason Cooper wrote:
> Guys,
> 
> I've held off several patches for the next window (nothing big),
> however, MikeT just took Ezequiel's clock divider driver for v3.13.  So,
> to keep things in sync, I'd appreciate it if you could take this last
> pull request containing only the corresponding dts and binding changes
> for that driver.

Hi,

I took this now but I think things such as clock bindings should be merged
through Mike's tree, since he's more familiar with how other drivers specify
similar bindings.


> The following changes since commit 1deb122c724edfd799a4d7d0b88ff14c365c9e69:
> 
>   ARM: Dove: fix bad properties of the si5351 clkout2 used by Cubox audio (2013-10-09 13:22:41 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/dt-3.13-4

Pulled into next/dt.


-Olof
