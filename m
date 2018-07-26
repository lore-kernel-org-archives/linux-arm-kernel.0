From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 12:25:32 -0700
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 4.19
In-Reply-To: <CACPK8XdcAANiSwsvCnu249W8QcFfjP616ce-YOW=UohgpTHtVw@mail.gmail.com>
References: <CACPK8XdcAANiSwsvCnu249W8QcFfjP616ce-YOW=UohgpTHtVw@mail.gmail.com>
Message-ID: <20180726192532.emdjzyaekz74ldqf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 02:03:11PM +0930, Joel Stanley wrote:
> Hello ARM Maintainers,
> 
> Here are the ASPEED defconfig updates for 4.19. It's been a while since I sent
> one, so this contains a lot of goodies.
> 
> The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:
> 
>   Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-4.19-defconfig
> 
> for you to fetch changes up to 90708adcd3ead258d4c2185da6acbe748eb0cc32:
> 
>   ARM: config: aspeed: Enable new FSI drivers (2018-07-26 13:27:27 +0930)
> 
> ----------------------------------------------------------------
> ASPEED defconfig updates for 4.19
> 
>  - Refresh the multi ARMv5 defconfig, and add AST2400 related drivers
> 
>  - Enable new ASPEED hardware that we've merged in the past few cycles.
>  There are about 14 different drivers since we last refreshed the
>  defconfig
> 
>  - Turn on features required by systemd, and other bits of OpenBMC
>  userspace
> 
>  - Enable security related options

Merged, two minor pieces of feedback:

1) I think you've cut-and-pasted the pull request into a mailer that line
   breaks between the URL and the tag. That's fine, but it means two copy and
   pastes at my end. Feel free to add a " \" at the end of the first line when
   you remember. We usually don't ask people to do it, it's purely for extra
   credit. :)

2) Please try to get these merge requests in before -rc6, or send what you have
   at that time even if you end up following up with just a few more patches
   later.


-Olof
