From: tj@kernel.org (Tejun Heo)
Date: Mon, 21 Jul 2014 09:16:19 -0400
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <20140721131233.GG15238@ulmo>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <111661024.qGiugVUugr@wuerfel> <20140717110652.GA18383@ulmo>
 <6373493.kzO00ziuYq@wuerfel> <20140721131233.GG15238@ulmo>
Message-ID: <20140721131619.GE12921@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:12:34PM +0200, Thierry Reding wrote:
> Adding Tejun, since he took this into his tree on Friday I think, just a
> few hours after I sent out pull requests for this.
> 
> I hadn't considered this build dependency. We could resolve this in two
> ways I think:
> 
> 	- merge the for-3.17/fuse-move branch from the Tegra tree into
> 	  the libata tree and apply Arnd's patch to the libata tree

I can pull the tegra tree into the libata if the tegra maintainer is
okay with it.

Thanks.

-- 
tejun
