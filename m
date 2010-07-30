From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 30 Jul 2010 15:23:56 +0800
Subject: [GIT PULL] debug macro changes for 2.6.36
In-Reply-To: <20100730071805.GB29746@n2100.arm.linux.org.uk>
References: <1280465905.11181.41.camel@pororo.lan>
	<20100730071805.GB29746@n2100.arm.linux.org.uk>
Message-ID: <1280474636.27902.1.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> No.  This change is far too big to come via git and will cause lots of
> conflicts.  I'm not fixing those conflicts when there's a better way
> of handling this kind of change.  There's also the matter of new platform
> support which your patch based approach will miss.
> 
> What I said about a week ago is that I wanted to do the removal of
> .phys_io/.io_pg_offst via a script, which'll ensure that we hit
> everything that's been merged for the next merge window.

OK, but how do you want me to submit this? Provide the other three
patches, plus a script to remove the machine_desc fields?

Cheers,


Jeremy
