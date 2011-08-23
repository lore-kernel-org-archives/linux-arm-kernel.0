From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Aug 2011 15:59:10 -0400 (EDT)
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.59575.166937.250550@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<20110823151421.GK19622@n2100.arm.linux.org.uk>
	<20051.55874.736418.528404@mariner.uk.xensource.com>
	<20110823173651.GH3895@n2100.arm.linux.org.uk>
	<20051.59575.166937.250550@mariner.uk.xensource.com>
Message-ID: <alpine.LFD.2.00.1108231550280.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2011, Ian Jackson wrote:

> If there are kernels intended to run on the secure side, a difficulty
> arises: if KVM wants to use Hyp mode and the associated features, how
> is that to be done ?

I think that you can safely presume that the secure world is not open to 
Open Source in practice.  As Russell said, all the actual 
implementations meant for products out there have the secure mode 
effectively burried behind ROM code that the SOC vendor controls.


Nicolas
