From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Aug 2013 14:04:56 -0400
Subject: [PATCH 1/2] ARM: mvebu: add support for the AXP WiFi AP board
In-Reply-To: <20130806200003.537d2e3f@skate>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375199091-31215-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806155343.GU19280@titan.lakedaemon.net>
 <20130806170941.GC2705@localhost> <20130806200003.537d2e3f@skate>
Message-ID: <20130806180456.GZ19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 08:00:03PM +0200, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Tue, 6 Aug 2013 14:09:42 -0300, Ezequiel Garcia wrote:
> 
> > When I cherry-pick commit 704cc70179481c814d581597a7d2cdbbeb152bee
> > (ARM: mvebu: add support for the AXP WiFi AP board) from mvebu/dt
> > into mvebu/mbus_dt, I found it's needed to apply the changes below.
> > 
> > If they look fine feel free to pick them, or request any other
> > base for them.
> > 
> > I don't have the board to test this, so maybe Seif can help
> > testing them?
> 
> Your two patches look good to me. Jason, if you merge them somewhere,
> it will make it easier for me to test them. I have the AXP WiFi AP
> board here to do the validation.

Ok, I'm probably going to move the original patch over to mvebu/mbus_dt,
then add Ezequiel's patch.  That should prevent any unnecessary
dependencies.

If I don't get to it tonight, it'll probably be sometime tomorrow (that
and MSI).

thx,

Jason.
