From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 15:19:57 +0100
Subject: [PATCH 0/3] Allow late mdesc detection, v4
In-Reply-To: <alpine.LFD.2.00.1010142331220.2764@xanadu.home>
References: <1282553423.737985.983362819420.0.gpush@pororo>
	<20100901073913.GF8142@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010142331220.2764@xanadu.home>
Message-ID: <20101018141956.GF12449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 11:42:04PM -0400, Nicolas Pitre wrote:
> I think that time has come, or is very close.  And since Jeremy is away 
> on vacation he asked me to handle the submission for those patches on 
> his behalf.
> 
> So... could you pull the following:
> 
> 	git://git.linaro.org/people/nico/linux debug_cleanup
> 
> It is currently based on your devel branch at commit f7de6b55ea4. If 
> you'd prefer another base just tell me.

I'm going to drop this - there's still a few trees which are outstanding
and this is causing problems... I think we have a few days left.

With Eric's changes merged, there's another io_pg_offst which has popped
up in mach-mmp, and there's a few new OMAP boards external to my tree
which are broken by this.
