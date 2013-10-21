From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Oct 2013 10:28:34 +0200
Subject: [PATCH] ASoC: kirkwood: cleanup the external clock probe
In-Reply-To: <20131021080657.GU25034@n2100.arm.linux.org.uk>
References: <20131021094613.2a07bd79@armhf>
 <20131021080657.GU25034@n2100.arm.linux.org.uk>
Message-ID: <20131021102834.768c0887@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Oct 2013 09:06:57 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Oct 21, 2013 at 09:46:13AM +0200, Jean-Francois Moine wrote:
> > This patch checks the return value of the clk_prepare_enable of the
> > external clock and removes the test about a same internal and external
> > clock which would quite never occur and won't work in most cases
> > it would occur.
> 
> NAK.  It can occur.

In which case? And, what would be the right treatment?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
