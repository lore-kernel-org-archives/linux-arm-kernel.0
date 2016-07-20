From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Jul 2016 17:54:18 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: tidyup SDHI register size on DTSI
In-Reply-To: <20160720085246.GA1673@katana>
References: <1469002759-2860-1-git-send-email-horms+renesas@verge.net.au>
 <20160720085246.GA1673@katana>
Message-ID: <20160720085417.GA9101@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 10:52:46AM +0200, Wolfram Sang wrote:
> 
> > -		reg = <0 0xee100000 0 0x200>;
> > +		reg = <0 0xee100000 0 0x384>;
> 
> All other r8a779x.dtsi have 0x328 there.

Wow! I wonder how I managed that.
