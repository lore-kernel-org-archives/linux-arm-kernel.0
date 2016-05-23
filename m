From: greg@kroah.com (Greg KH)
Date: Mon, 23 May 2016 08:36:19 -0700
Subject: [PATCH 0/2 (linux-stable-4.5.y)] net: stmmac: MDIO fixes
In-Reply-To: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
References: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
Message-ID: <20160523153619.GA30179@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 03:17:41PM +0200, Giuseppe Cavallaro wrote:
> These patches port some recent fixes for linux-4.5.y stable branch.
> They fix the MDIO settings trying to cover the all possible scenario
> when the stmmac is connected to a real transceiver or a switch.
> 
> These patches are needed for Kernel 4.5 where Lime2, BananaPi and Cubieboard2
> show problems when use the stmmac:
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823493

What are the git commit id for these patches in Linus's tree?

thanks,

greg k-h
