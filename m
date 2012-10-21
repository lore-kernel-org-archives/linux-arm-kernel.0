From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 20 Oct 2012 21:05:04 -0400
Subject: [PATCH v2 0/4] Add DT support for Network Space v2 and parents
In-Reply-To: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20121021010504.GB25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 12:09:02PM +0200, Simon Guinot wrote:
> This patch series provides DT support for LaCie NAS Network Space v2 and
> parents. This includes the following machines:
>  - Internet Space v2
>  - Network Space v2
>  - Network Space Max v2
>  - Network Space Lite v2
>  - Network Space Mini v2
> 
> Note that the three first boards are already supported by the Linux
> kernel via an "old-fashion" board setup. The two lasts (Lite and Mini)
> are new boards.
> 
> Also note that the first patch of the series is related with the LED
> subsystem. It adds device tree binding to the driver leds-ns2.


Series applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

thx,

Jason.
