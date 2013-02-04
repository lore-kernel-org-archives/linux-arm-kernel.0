From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 4 Feb 2013 09:27:53 +0000
Subject: [PATCH 09/26] mfd: ab8500-debugfs: Provide a means for a user
 subscribe to IRQs
In-Reply-To: <20130203170158.GO8476@sortiz-mobl>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-10-git-send-email-lee.jones@linaro.org>
 <20130127235259.GO1174@sortiz-mobl>
 <20130128102223.GA18212@gmail.com>
 <20130128104933.GY1174@sortiz-mobl>
 <20130128113443.GB18212@gmail.com>
 <20130203170158.GO8476@sortiz-mobl>
Message-ID: <20130204092753.GW2042@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > I'm going to have to put this patch-set in the bin. Pulling this
> > > > patch, causes lots of conflicts to the remaining patches in the
> > > > set.
> > > I bet removing this one causes a lot of conflicts. I'm not saying it should
> > > absolutely be removed, but I'm afraid once it's upstream no one is going to
> > > look at improving it.
> > 
> > This is really not the case. 
> I trust you here, but usually people get busy with other stuff after their
> patchset is upstreamed and never get back to me on the initial issues.
> 
> > I have every intention of fixing each and
> > every issue which are brought to my attention during the upstreaming
> > process of 'drivers/regulators', 'drivers/power' and 'drivers/mfd'.
> > 
> > All I'm doing is making a list of all the fixups and re-writes and
> > I'll address them on the completion of the push. Hence if you're happy
> > for this to go in with my promise of improvement, it would certainly
> > make this task a great deal easier for me.
> I'll take your words here. I'll apply this one once you adressed the other
> issues I commented about on this patchset.

Fixups complete, pull-request sent.

> > > And to be honest, having an IRQ handler from debugfs
> > > code looks weird to me. I know you can put all sort of crazyness into a
> > > debugfs entry, but still.
> > >  
> > > > I'll start again from scratch and find another way to sync the ab* MFD
> > > > drivers. I might even have to do it manually i.e. throw out all
> > > > commit history and upstream it as my own patches pulled in from diffs.
> > > I don't have any problems with that.
> > 
> > I'm sure you don't, but it's me that's doing all the hard work. ;)
> What's wrong with that ? ;)

Hmmm... :D

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
