From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 8 Mar 2013 17:03:49 +0100 (CET)
Subject: [PATCH 3/4][V2] ARM: nomadik: add dynamic irq flag to the
 timer
In-Reply-To: <513A0109.9060801@linaro.org>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org>
 <513A0109.9060801@linaro.org>
Message-ID: <alpine.LFD.2.02.1303081703160.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Mar 2013, Daniel Lezcano wrote:

> > Add the dynamic irq affinity feature to the timer clock device.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
> > ---
> 
> Hi Linus,
> 
> AFAIU, you are ok with this patch, Rickard acked it and Vincent reviewed it.
> 
> Thomas agreed to merge it into its tree as I requested because we will
> need to wait for your tree to gain visibility to this new flag before
> submitting this patch, which can take awhile.
> 
> Could you please ack it if it is ok for you ?

I can provide a for-arm tree to pull as well. Either way fine with me.

Thanks,

	tglx
