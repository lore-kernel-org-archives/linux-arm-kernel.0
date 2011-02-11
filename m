From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Feb 2011 00:42:29 -0200
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <1297372554-19527-1-git-send-email-GNUtoo@no-log.org>
References: <1297372554-19527-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <AANLkTimHRbwrZCp2D0cZ54A+DAj=QGNLus09Je5_=zzj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Thu, Feb 10, 2011 at 7:15 PM, Denis 'GNUtoo' Carikli
<GNUtoo@no-log.org> wrote:
> This work was based on bug-linux-2.6.30.patch that can be found
> ?in buglabs's svn here:
> ?svn://bugcamp.net/bug/branches/izzy/experimental
>
> Note that the hardware schematics and documentations can be obtained
> ?here: http://www.bugcommunity.com/wiki/index.php/BUGbase
>
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> ---
> ?arch/arm/mach-mx3/Kconfig ? ? ? ? ? ?| ? ?9 +++
> ?arch/arm/mach-mx3/Makefile ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mx3/mach-mx31bugbase.c | ? 97 ++++++++++++++++++++++++++++++++++
> ?3 files changed, 107 insertions(+), 0 deletions(-)

Please add an entry for this board at
arch/arm/plat-mxc/include/mach/uncompress.h

Regards,

Fabio Estevam
