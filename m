From: dilinger@queued.net (Andres Salomon)
Date: Fri, 4 Mar 2011 08:38:22 -0800
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <4D710FF9.6040305@ru.mvista.com>
References: <20110304080653.3f2c3f19@debxo>
	<4D710FF9.6040305@ru.mvista.com>
Message-ID: <20110304083822.0f40d120@debxo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Mar 2011 19:14:49 +0300
Sergei Shtylyov <sshtylyov@mvista.com> wrote:

> Hello.
> 
> Andres Salomon wrote:
> 
> > Note that this relies on stuff currently in mfd's next tree, but
> > this is also a newer driver.  I'm not sure which tree it should go
> > through, as it's a problem that shows up in next.
> 
>     This passage should be under --- tear line.

What?


> 
> > From: Andres Salomon <dilinger@queued.net>
> 
> > MFD changes in c738892f cause the mc13xxx_platform_data struct
> 
>     Linus asks to also specify the commit summary in parens.
> 

Also, what?  If there are changes to how patches should be submitted,
please provide a reference (Documentation/SubmittingPatches should
be updated, as well).



> > to change.  This changes one more (new) user of it, fixing a build
> > error.
> 
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> 
> WBR, Sergei
