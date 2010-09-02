From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 14:08:40 +0100
Subject: [PATCH 45/74] SPEAr : SEV Send event to secondary CPUs
In-Reply-To: <003f01cb4a8b$372d0d00$a5872700$@deacon@arm.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<861ddbfab51ade4893ef92df4bcfa9b203844a9c.1283161023.git.viresh.kumar@st.com>
	<20100902102256.GO26319@n2100.arm.linux.org.uk>
	<003f01cb4a8b$372d0d00$a5872700$@deacon@arm.com>
Message-ID: <20100902130840.GD26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 11:40:08AM +0100, Will Deacon wrote:
> There was patch posted last month from Code Aurora:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/021401.html
> 
> which proposed adding a sev() macro to processor.h. They also added
> a wfe() macro, so maybe all of this should go in system.h instead.

I think so, and system.h seems to be a better place for it.
