From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 2 Apr 2012 08:52:46 +0200
Subject: [PATCH 3/3] mmc: atmel-mci: add support for odd clock dividers
In-Reply-To: <87mx6wm7yu.fsf@laptop.org>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
 <1332344483-3915-4-git-send-email-ludovic.desroches@atmel.com>
 <4F6B3BD0.4060702@atmel.com> <87mx6wm7yu.fsf@laptop.org>
Message-ID: <20120402065246.GC3082@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Sat, Mar 31, 2012 at 11:44:41PM -0400, Chris Ball wrote:
> Hi,
> 
> On Thu, Mar 22 2012, Nicolas Ferre wrote:
> > On 03/21/2012 04:41 PM, ludovic.desroches at atmel.com :
> >> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >> 
> >> Add an odd clock divider capability available from v5xx. It also involves
> >> changing the clock divider calculation.
> >
> > Also tell here that you have changed the way that the switch/case
> > directive has been implemented.
> >
> >> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> > Otherwise:
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks, pushed to mmc-next for 3.4 with a rewording:
> 
>     Add an odd clock divider capability available from v5xx. It also involves
>     changing the clock divider calculation, and changing the switch-case
>     statement to use top-down fallthrough.
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

Thanks for rewording the commit message.


Regards

Ludovic
