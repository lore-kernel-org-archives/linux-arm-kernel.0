From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 12:33:20 -0400
Subject: [PATCH, RESEND] arm: kirkwood: readynas duo v2: Add GMT G762
 Fan Controller
In-Reply-To: <874nceui0h.fsf@natisbad.org>
References: <874nceui0h.fsf@natisbad.org>
Message-ID: <20130725163320.GL23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 10:45:02PM +0200, Arnaud Ebalard wrote:
> 
> Now that GMT G762 PWM Fan Controller is available upstream, let's add
> missing bindings in Netgear ReadyNAS Duo v2 .dts file.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> Hi Jason and Andrew,
> 
> This one applies and has been tested against Stephen Rothwell tree.
> Can you make it flow to Linus tree during the merge window?
> 
> Following Thomas feedback, this is a resend of previous version, this
> time w/o fixes for bad spaces at the end of the file. Just tell me if
> I should send a separate one for that purpose.
> 
> Thanks in advance.
> 
> Cheers,
> 
> a+
> 
>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts    | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied to mvebu/dt

thx,

Jason.
