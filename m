From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Sep 2014 19:52:26 -0700
Subject: [PATCHv3 0/5] OMAP Mailbox framework adoption & DT support
In-Reply-To: <20140908232053.GS3238@atomide.com>
References: <1406680479-18446-1-git-send-email-s-anna@ti.com>
 <20140908232053.GS3238@atomide.com>
Message-ID: <20140909025225.GI10785@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140908 16:21]:
> * Suman Anna <s-anna@ti.com> [140729 17:37]:
> > Hi,
> > 
> > This is an updated version of the OMAP Mailbox framework adoption &
> > DT support series, refreshed to work with the v9 version of the mailbox
> > framework [1] from Jassi Brar while also addressing some minor review
> > comments. Detailed changes are summarized below. Patches are based on
> > 3.16-rc2.
> 
> Sorry for the delay, just noticed that I'm supposed to queue
> these too. I'll queue these into omap-for-v3.18/mailbox against
> v3.17-rc1 and will probably also merge it into omap-for-v3.18/dt
> as well.

Actually this is not compiling and seems to probably miss
the dependencies from Jassi, so dropping the branch.

Anyways, since it seems you need to repost this again, please
repost the DT changes separately from the driver changes.

Regards,

Tony
