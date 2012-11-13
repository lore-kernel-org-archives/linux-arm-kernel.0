From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Nov 2012 13:46:45 -0500
Subject: arm: mvebu: Pull request for 'marvell-boards' branch
In-Reply-To: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121113184645.GA22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Nice to see a pull request from you guys!

Comments below:

On Mon, Nov 12, 2012 at 06:20:33PM +0100, Thomas Petazzoni wrote:
> Jason, Andrew,
> 
> The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:
> 
>   Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)
> 
> are available in the git repository at:
> 
>   git at github.com:MISL-EBU-System-SW/mainline-public.git marvell-boards
> 
> for you to fetch changes up to 39325a96e1d082bf71b7a4d9ac2d5806f80c6d13:
> 
>   arm: mvebu: add LED support in defconfig (2012-11-12 18:13:41 +0100)
> 
> ----------------------------------------------------------------

I'd like to see a signed tag in here.  If you could have gregory send me
a signed email with all the fingerprints you guys traded at ELCE, I'd
appreciate it.

In the future, could you please break these up into the following
branches:

> Gregory CLEMENT (1):
>       arm: mvebu: support for the Globalscale Mirabox board

boards

> Thomas Petazzoni (5):
>       arm: mvebu: fix compatible string in armada-370-xp.dtsi
>       arm: mvebu: don't list all boards in dt compat field for Armada 370/XP
>       arm: mvebu: fix typo in machine name for Armada 370/XP

cleanup (also, if any are fixing problems found in older kernels, please
add a CC to stable as appropriate)

>       arm: mvebu: support for the PlatHome OpenBlocks AX3-4 board

boards

>       arm: mvebu: add LED support in defconfig

defconfig

That would really help me out.  Otherwise, I have to pull this branch
and cherry-pick the patches into different branches.  Which kind of
defeats the purpose of the pull request. ;-)

thx,

Jason.
