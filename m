From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 3 Nov 2016 22:03:54 +0100
Subject: [PATCHv2] ARM: OMAP3: Fix formatting of features printed
In-Reply-To: <20161103173439.20657-1-tony@atomide.com>
References: <20161103173439.20657-1-tony@atomide.com>
Message-ID: <20161103210354.qtf4ljbcmcgtvo6j@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 03, 2016 at 10:34:39AM -0700, Tony Lindgren wrote:
> With the printk cleanups merged into v4.9-rc1, we now get the omap
> revision printed on multiple lines. Let's fix that and also remove the
> extra empty space at the end of the features. And let's update things
> to use scnprintf as suggested by Ivaylo Dimitrov
> <ivo.g.dimitrov.75@gmail.com>.
> 
> Reported-by: Adam Ford <aford173@gmail.com>
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/id.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/cb911b5c/attachment.sig>
