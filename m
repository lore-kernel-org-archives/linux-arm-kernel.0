From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 14 Jun 2010 18:18:24 +0800
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100611042046.GA31045@fluff.org.uk>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<1275636608.607067.417709988883.1.gpush@pororo>
	<20100611042046.GA31045@fluff.org.uk>
Message-ID: <201006141818.26954.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

I've just pushed to my clk-common branch, mostly involving the changes we've 
discussed so far.

http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=commitdiff;h=f2c5141c88aa4c5ba82aee1b5b8abe5e9ff09146

The clk-common-mx51 and clk-common-versatile branches both contain basic ports 
of the mx51 and versatile platforms to the new clock infrastructure.

Cheers,


Jeremy
