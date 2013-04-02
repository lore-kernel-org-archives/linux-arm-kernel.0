From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Apr 2013 07:50:51 -0400
Subject: [PATCH 4/6] arm: orion5x: move ts78xx to use rtc-m48t86 driver
 side memory interface
In-Reply-To: <1364858565-17192-5-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
 <1364858565-17192-5-git-send-email-alex@digriz.org.uk>
Message-ID: <20130402115051.GS13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 12:22:43AM +0100, Alexander Clouter wrote:
> Remove platform_data hooks into rtc-m48t86 and use named resource regions.
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/mach-orion5x/ts78xx-setup.c |   78 ++++++++--------------------------
>  1 file changed, 17 insertions(+), 61 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
