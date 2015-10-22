From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 10:41:37 -0700
Subject: [GIT PULL] ARM: mvebu: soc for v4.4 (#2)
In-Reply-To: <87vba6g11k.fsf@free-electrons.com>
References: <87vba6g11k.fsf@free-electrons.com>
Message-ID: <20151022174137.GB31793@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 07:45:27PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second pull request for soc for mvebu for v4.4.
> 
> Gregory
> 
> The following changes since commit d492cccac28493f26bb70038385a9ef4df19bdee:
> 
>   ARM: mvebu: add support to clear shared L2 bit on Armada XP (2015-09-29 15:31:51 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.4-2
> 
> for you to fetch changes up to 400b1b26b44f1c5de45bc01873f42c9e776e102e:
> 
>   ARM: orion5x: use mac_pton() helper (2015-10-15 09:37:18 +0200)
> 
> ----------------------------------------------------------------
> mvebu soc for 4.4 (part 2)
> 
> - Use mac_pton() helper in the oropn5x board instead of duplicating it
> - Add the broken-idle option allowing to boot boards with a mistake in
>   the hardware design
> 
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       ARM: orion5x: use mac_pton() helper
> 
> Vincent Donnefort (1):
>       ARM: mvebu: add broken-idle option

I just posted a comment on this patch, the code should be revisited.

A small incremental pull request like this is OK late, so there's still time to
fix that for 4.4. Please send a new request when done!


Thanks,

-Olof
