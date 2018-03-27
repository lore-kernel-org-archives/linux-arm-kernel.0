From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 27 Mar 2018 23:53:33 +0200
Subject: [PATCH 4/6] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
In-Reply-To: <20180223101553.GE5746@lenoch>
References: <20180223101254.GA5746@lenoch>
 <20180223101553.GE5746@lenoch>
Message-ID: <20180327215332.GC28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 11:15:53AM +0100, Ladislav Michl wrote:
> Prescaler setting is currently not taken into account.
> Fix that by introducing freq member variable and initialize
> it at device probe time. This also avoids frequency
> recomputing at each pwm configure time.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 93 +++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 38 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/ab6ece91/attachment.sig>
