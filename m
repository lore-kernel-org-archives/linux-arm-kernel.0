From: plyatov@gmail.com (Igor Plyatov)
Date: Mon, 13 Dec 2010 10:15:40 +0300
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <20101212140727.GI19897@game.jcrosoft.org>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
	<20101212005048.GH19897@game.jcrosoft.org>
	<1292135848.2456.19.camel@homepc>
	<20101212140727.GI19897@game.jcrosoft.org>
Message-ID: <1292224540.4117.16.camel@homepc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Christophe,

> sorry as I explain before if you have exclusive option you need to create
> kconfig options which are board specific to manage them
> we work to reduce the number of defconfig in the mainline
> and it's not PortuxG20 and Stamp9g20 specific but to have only one defconfig
> for all 9g20 at a first step and late for all sam9

Thank you for time spent on my patches and e-mails!
I was think to do it this way, but unsure that this is a right way.
Now, with yours help, I know what to do.

> > > your patch contain a lots of whitespace please fix it
> > 
> > There is no problems with whitespace. This patch checked by
> > scripts/checkpatch.pl twice. It seems your mailer corrupt this patch.
> my mailer no way mutt does not do it
> and when I edit with vim I saw the whitespace too
> please check again

I found this whitespaces. There is something strange inside of gedit,
because I does not have practice to use spaces for formatting.
It seems, time to learn vi, come :-)

> > Please, use more testimony why it is required to use system_rev here.
> > Yours position does not clear for me.
> > You can point me to the right documentation or discussion about this
> > requirements in the mail archives...
> two bards with the same machine id NACK as we can not compile them in the same
> kernel and this a target we all work on to allow
> if you want to tuse the same machine id as I did for other boards you must use
> system_rev or any detection to identify tehm

OK. I will use the GSIA18S machine instead of the STAMP9G20.
The GSIA18S already registerd in the ARM machines database.

Best regards!
--
Igor Plyatov
