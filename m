From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 21:02:33 -0400
Subject: [PATCH v2 1/2] ARM: mvebu: Use the a standard errno in
 mvebu_get_soc_id
In-Reply-To: <1403274953-21790-2-git-send-email-gregory.clement@free-electrons.com>
References: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
 <1403274953-21790-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140621010233.GY21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 04:35:52PM +0200, Gregory CLEMENT wrote:
> Instead of using -1 as error value, use a standard errno.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/mvebu-soc-id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/soc

thx,

Jason.
