From: Larry.Finger@lwfinger.net (Larry Finger)
Date: Sun, 04 Oct 2009 18:01:40 -0500
Subject: [RFC PATCH 05/10] PCMCIA: sa1111: wrap soc_pcmcia_socket to
	contain sa1111 specific data
In-Reply-To: <485cc33b078bb619d4544cf31388401dd1708029.1253722954.git.rmk+kernel@arm.linux.org.uk>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
	<485cc33b078bb619d4544cf31388401dd1708029.1253722954.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <4AC92954.1010104@lwfinger.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/pcmcia/pxa2xx_base.c       |   19 +++++++----
>  drivers/pcmcia/pxa2xx_base.h       |    3 ++
>  drivers/pcmcia/pxa2xx_lubbock.c    |   10 ++++--
>  drivers/pcmcia/sa1100_badge4.c     |    7 ++++-
>  drivers/pcmcia/sa1100_jornada720.c |   20 ++++++++----
>  drivers/pcmcia/sa1100_neponset.c   |    9 ++++-
>  drivers/pcmcia/sa1111_generic.c    |   58 ++++++++++++++++++++++++++++--------
>  drivers/pcmcia/sa1111_generic.h    |   14 ++++++++
>  drivers/pcmcia/sa11xx_base.c       |   21 ++++++++----
>  drivers/pcmcia/sa11xx_base.h       |    2 +
>  10 files changed, 123 insertions(+), 40 deletions(-)

What tree is this patch for? I get the following errors when applying
to taday's pull of Linus's tree (git describe is
v2.6.32-rc1-384-ga99bbaf):

patching file drivers/pcmcia/sa1100_jornada720.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 40.
Hunk #3 FAILED at 85.
Hunk #4 FAILED at 101.
4 out of 4 hunks FAILED -- rejects in file
drivers/pcmcia/sa1100_jornada720.c
