From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 25 Jan 2010 11:20:57 +0000
Subject: Cortex-m3 Kernel Port.
In-Reply-To: <1264417594.6275.5.camel@pc1117.cambridge.arm.com>
References: <aecf5e531001242215g5f2c42c8q458637f024a40521@mail.gmail.com>
	<1264417594.6275.5.camel@pc1117.cambridge.arm.com>
Message-ID: <20100125112057.GA3536@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Mon, 2010-01-25 at 06:15 +0000, Sasa Sasa wrote:
> > What is the status of the cortex-m3 kernel port ? Is it merged to
> > mailine ?
> 
> No and I wasn't planning to unless there are more people using it to be
> worth the maintenance effort (the Cortex-M3 platforms I've seen have too
> little RAM to be able to run Linux).

How much do they have?  People are running uClinux in 8-16MB; it's
tight squeeze but sometimes worth it.  If it has an MMU it would need
a bit less memory.

-- Jamie
