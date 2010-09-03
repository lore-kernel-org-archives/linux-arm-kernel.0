From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Sep 2010 08:32:46 +0100
Subject: [PATCH 08/74] ST SPEAr1300: Adding default config file
In-Reply-To: <alpine.LFD.2.00.1009022143420.19366@xanadu.home>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<3a583e07221d909bd4afb952bbf2a38a2d25cdf4.1283161023.git.viresh.kumar@st.com>
	<20100902085127.GE26319@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1009022143420.19366@xanadu.home>
Message-ID: <20100903073246.GE26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 09:45:23PM -0400, Nicolas Pitre wrote:
> On Thu, 2 Sep 2010, Russell King - ARM Linux wrote:
> 
> > On Mon, Aug 30, 2010 at 04:08:39PM +0530, Viresh KUMAR wrote:
> > > From: Shiraz Hashim <shiraz.hashim@st.com>
> > 
> > This defconfig is too large and verbose to go anywhere near mainline,
> > even temporarily.  You need to talk to Uwe about how to shrink it down.
> 
> These days, all you need to do is:
> 
> 	  make savedefconfig
> 
> and look for a defconfig file in the current directory.

Ah right.  Wonder why no one documented that.
