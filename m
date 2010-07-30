From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 30 Jul 2010 17:00:56 +0800
Subject: [GIT PULL] debug macro changes for 2.6.36
In-Reply-To: <20100730081419.GA3208@n2100.arm.linux.org.uk>
References: <1280465905.11181.41.camel@pororo.lan>
	<20100730071805.GB29746@n2100.arm.linux.org.uk>
	<1280474636.27902.1.camel@pororo.lan>
	<20100730081419.GA3208@n2100.arm.linux.org.uk>
Message-ID: <1280480456.27902.14.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> My intention was to have your patch merged - as patches - into an
> appropriate place in my tree, and then just before the merge window
> run that script to remove all the references to phys_io/io_pg_offst,
> and finally, some time later, the members from the structure.

In that case, I assume you want the updated patches to do the macro
changes. I'll send those as a series soon.

I'll drop all of the changes to machine-specific initialisers, leaving
only the changes to struct machine_desc. You can apply (or drop) that as
you wish.

Cheers,


Jeremy
