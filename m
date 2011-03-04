From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 04 Mar 2011 21:58:56 +0300
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <20110304083822.0f40d120@debxo>
References: <20110304080653.3f2c3f19@debxo>	<4D710FF9.6040305@ru.mvista.com>
	<20110304083822.0f40d120@debxo>
Message-ID: <4D713670.70506@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Andres Salomon wrote:

>>> Note that this relies on stuff currently in mfd's next tree, but
>>> this is also a newer driver.  I'm not sure which tree it should go
>>> through, as it's a problem that shows up in next.

>>     This passage should be under --- tear line.

> What?

    See Documentation/SubmittingPatches, section 15, "The canonical patch format".

>>> From: Andres Salomon <dilinger@queued.net>

>>> MFD changes in c738892f cause the mc13xxx_platform_data struct

>>     Linus asks to also specify the commit summary in parens.

> Also, what?  If there are changes to how patches should be submitted,
> please provide a reference (Documentation/SubmittingPatches should
> be updated, as well).

    I have no time to rummage in the mail archives, sorry.

>>> to change.  This changes one more (new) user of it, fixing a build
>>> error.
>>> Signed-off-by: Andres Salomon <dilinger@queued.net>

WBR, Sergei
