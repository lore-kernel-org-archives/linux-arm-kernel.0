From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 02 Sep 2010 21:45:23 -0400 (EDT)
Subject: [PATCH 08/74] ST SPEAr1300: Adding default config file
In-Reply-To: <20100902085127.GE26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<3a583e07221d909bd4afb952bbf2a38a2d25cdf4.1283161023.git.viresh.kumar@st.com>
	<20100902085127.GE26319@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1009022143420.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Sep 2010, Russell King - ARM Linux wrote:

> On Mon, Aug 30, 2010 at 04:08:39PM +0530, Viresh KUMAR wrote:
> > From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> This defconfig is too large and verbose to go anywhere near mainline,
> even temporarily.  You need to talk to Uwe about how to shrink it down.

These days, all you need to do is:

	  make savedefconfig

and look for a defconfig file in the current directory.


Nicolas
