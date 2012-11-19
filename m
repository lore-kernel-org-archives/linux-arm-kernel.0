From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 18 Nov 2012 18:32:52 -0800
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <8058793.mIXgB85Mso@percival>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121117113849.GA5228@lizard> <8058793.mIXgB85Mso@percival>
Message-ID: <20121119023251.GA2131@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:29:05AM +0900, Alex Courbot wrote:
> On Saturday 17 November 2012 19:38:50 Anton Vorontsov wrote:
> > > +++ b/drivers/power/power_seq/Kconfig
> > > @@ -0,0 +1,2 @@
> > > +config POWER_SEQ
> > > +	tristate
> > 
> > This really needs a proper Kconfig description and a help text, shortly
> > describing the purpose of the subsystem.
> 
> Does it? The current state makes power seqs automatically selected by drivers 
> that need it, and they do not appear in the configuration menu. If we add a 
> description they will then become a visible item, so the logic would be to 
> make it user-selectable.

Ah. OK, then yes, there is no need for the short description, but the help
text would a good idea anyway.

Thanks,
Anton.
