From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 7 Dec 2015 10:36:14 +0800
Subject: [PATCH v2 PART-RESEND 0/2] berlin sdhci clock clean up
In-Reply-To: <566408ED.9040902@gmail.com>
References: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
 <564E3191.8060109@gmail.com>	<566408ED.9040902@gmail.com>
Message-ID: <20151207103614.04bafa78@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Sun, 6 Dec 2015 11:07:41 +0100
Sebastian Hesselbarth wrote:

> On 19.11.2015 21:31, Sebastian Hesselbarth wrote:
> > On 16.11.2015 11:56, Jisheng Zhang wrote:  
> >> Add or fix the optional clock property, then remove the CLK_IGNORE_UNUSED
> >> flag for sdio clk(s).
> >>
> >> This is a partialy resend of 
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379457.html
> >>
> >> patch3, patch4 has been merged.  
> > 
> > Great! Really!
> > 
> > As they have been taken without my Acked-by, ignoring my request to
> > _not_ remove the CLK_IGNORE_UNUSED flags _before_ these two, the
> > remaining patches now become fixes.
> > 
> > Please resend the patches with a proper description what and why they
> > are fixes now.  
> 
> Is this going to be resolved anytime soon?
> 
> If not, I am going to send a revert for the CLK_IGNORE_UNUSED patch
> and we start this from the beginning.

I will send patches today.

Thanks a lot,
Jisheng
