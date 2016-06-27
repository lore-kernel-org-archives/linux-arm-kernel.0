From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 27 Jun 2016 17:16:18 +0200
Subject: [PATCH v2 1/2] ARM: tango: add HOTPLUG_CPU support
In-Reply-To: <57690962.8050701@sigmadesigns.com>
References: <576908D6.8090000@sigmadesigns.com>
 <57690962.8050701@sigmadesigns.com>
Message-ID: <57714342.7060006@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2016 11:31, Marc Gonzalez wrote:

> cpu_die() and cpu_kill() are implemented in firmware.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/mach-tango/platsmp.c | 17 +++++++++++++++++
>  arch/arm/mach-tango/smc.h     |  4 +++-
>  2 files changed, 20 insertions(+), 1 deletion(-)

There's a bug in my patch. I'll send an update.

Regards.
