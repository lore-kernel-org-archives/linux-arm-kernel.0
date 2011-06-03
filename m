From: Artem.Bityutskiy@nokia.com (Artem Bityutskiy)
Date: Fri, 03 Jun 2011 07:38:25 +0300
Subject: [PATCH 1/2] clps711x/ceiva: port to use physmap flash
In-Reply-To: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
References: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1307075905.4405.130.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-06-02 at 15:54 +0400, Dmitry Eremin-Solenikov wrote:
> Port ceiva machine to use physmap flash instead of custom mapping driver
> (which even can't compile cleanly with current kernels). All info
> is gathered from drivers/mtd/maps/ceiva.c. Compile tested only.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-clps711x/ceiva.c |   60 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)

Is ceiva used and not dead? May be we could kill it completely?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
