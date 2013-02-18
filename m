From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Feb 2013 10:32:39 +0900
Subject: [PATCH 5/5] ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START
In-Reply-To: <87621qo2tc.wl%kuninori.morimoto.gx@renesas.com>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
 <1360933261-6359-6-git-send-email-horms+renesas@verge.net.au>
 <87621qo2tc.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130218013238.GB11807@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 04:58:46PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Remove .init_late and .restart from DT_MACHINE_START
> > for kzm9g reference as these are not necessary to
> > bring the board up which is the main aim of kzm9g reference.
> 
> Does this mean that we will have "full spec kzm9g DT base" code in the future,
> and then, "kzm9g reference" code will be deleted ?

Yes, I think that is the plan.
