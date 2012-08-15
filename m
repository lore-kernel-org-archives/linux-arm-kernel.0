From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 12:37:56 +0000
Subject: [GIT PULL] orion/kirkwood fixes for v3.6
In-Reply-To: <20120814234442.GZ22226@titan.lakedaemon.net>
References: <20120814234442.GZ22226@titan.lakedaemon.net>
Message-ID: <201208151237.56639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Jason Cooper wrote:
> The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> 
>   Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6
> 

Pulled, thanks!

As soon as you have a pgp key that is signed by other maintainers,
I think you should start sending signed tags instead of branches,
and include a short description for what is in the branch you are
sending. I've started adding descriptions for every merge I do
and it's easier for me if I don't have to write it myself.

The first patch in your series (ARM: Orion: Set eth packet size
csum offload limit) looks like it should apply to older kernels
as well. In those cases, please add "Cc: stable at vger.kernel.org"
below the Signed-off-by lines (but not in the email submission)
so it can get picked up by Greg for the longterm and stable
releases.

	Arnd
