From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 17:09:40 +0000
Subject: [GIT PULL 1/4] ARM: mvebu: cleanup for v3.9
In-Reply-To: <20130216195507.GH23237@titan.lakedaemon.net>
References: <20130216195507.GH23237@titan.lakedaemon.net>
Message-ID: <201302191709.40302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Jason Cooper wrote:
> The following changes since commit b3af7a1ffd1e5e9ec536a915393b7e07a8793f2a:
> 
>   ARM: dove: cleanup includes (2013-01-31 14:23:21 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/cleanup_for_v3.9_round3
> 
> for you to fetch changes up to 7a87c8ab68d0343fd58bb1249219959a239501bf:
> 
>   ARM: mvebu: correct gated clock documentation (2013-02-15 20:32:38 +0000)
> 
> ----------------------------------------------------------------
> mvebu cleanup vor v3.9 round3
> 
>  - fix typo in mvebu clokc gating documentation.
> 
> ----------------------------------------------------------------
> Jason Cooper (1):
>       ARM: mvebu: correct gated clock documentation
> 
>  Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Pulled into next/cleanup, as this is obviously a bug fix for the previous
contents of that branch.

	Arnd
