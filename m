From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 2 Apr 2012 08:51:19 +0200
Subject: [PATCH 0/4] atmel-mci device tree support
In-Reply-To: <87iphkm7r4.fsf@laptop.org>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
 <87iphkm7r4.fsf@laptop.org>
Message-ID: <20120402065118.GB3082@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Sat, Mar 31, 2012 at 11:49:19PM -0400, Chris Ball wrote:
> Hi,
> 
> On Wed, Mar 21 2012, ludovic.desroches at atmel.com wrote:
> > Hi,
> >
> > This patch-set adds device tree support for atmel-mci.
> 
> Please can you resend after syncing up with Arnd's suggestions in:
>    http://thread.gmane.org/gmane.linux.kernel.samsung-soc/9216/focus=13659
> 
> (It looks like the main difference is just s/cd-invert;/cd-inverted;/.)

I have already sent a v2 version. I will send the v3 version once a decision
about bindings would be taken.

I think the cd-invert (or cd-inverted) property will be removed since we can
get the information with gpio flags.

> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

Regards

Ludovic
