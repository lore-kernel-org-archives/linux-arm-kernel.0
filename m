From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 05 Mar 2011 14:37:11 -0500 (EST)
Subject: [PATCHv2] [ARM] orion5x: use safer FPGA ID 'default' for TS-78xx
In-Reply-To: <20110305114936.GD22117@chipmunk>
References: <20110305112937.GA22117@chipmunk> <20110305114936.GD22117@chipmunk>
Message-ID: <alpine.LFD.2.00.1103051432380.27995@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Mar 2011, Alexander Clouter wrote:

> Originally the FPGA ID checking switch statement left disabled all the
> TS implemented FPGA devices if the ID was unknown to it.  Michael Spang
> created a fix in 3c390473 that changed the default to enable the devices

If you want to abbreviate commit hash values, you should keep the 
beginning of them not the end.  This commit is:

	commit f9b1184e12e5ff8129b04837dffddb5a3c390473

So a shorter form would be f9b1184e.  I amended it locally.


Nicolas
