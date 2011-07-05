From: mgrosen@ti.com (Grosen, Mark)
Date: Tue, 5 Jul 2011 16:54:14 +0000
Subject: [RFC 5/8] remoteproc: add davinci implementation
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D91A2BE@dbde02.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F29@dbde02.ent.ti.com>
	<FFF198FBBF957F4393BA834040FEFFA202EC99@DFLE35.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D91A2BE@dbde02.ent.ti.com>
Message-ID: <FFF198FBBF957F4393BA834040FEFFA2032F69@DFLE35.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Nori, Sekhar
> Sent: Monday, July 04, 2011 10:30 PM

...
> > > https://patchwork.kernel.org/patch/662941/
> >
> > Yes, I like this idea - much cleaner. For example, the start() method
> > becomes (pseudo-code):
> >
> > start()
> > {
> >     /* bootaddrreg derived from platform data */
> >     bootaddrreg = boot_address;
> >
> >     clk_enable();
> > }
> >
> > Referring to your patch above, would it be better to just pass
> > the flags into the davinci_psc_config() function rather than breaking
> out more
> > arguments for each flag?
> 
> I did dwell on this quite a bit while writing that
> patch, but finally decided on passing an argument
> instead since I was not sure if there are going
> to be more modifiers required.
> 
> Now that you have the need for one more flag, I
> think we should go ahead and pass the flags directly
> to davinci_psc_config(). My original patch is not
> upstream yet. I will re-spin it and you can build
> on top of it.

Thanks, Sekhar, this sounds good. I'll look for your patch and utilize
it in the next rev of this patch.

Mark
