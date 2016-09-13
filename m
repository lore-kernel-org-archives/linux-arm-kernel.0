From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 14 Sep 2016 06:58:15 +1000
Subject: [PATCH v3 4/7] palmetto: Request relevant mux functions in
 devicetree
In-Reply-To: <CACPK8Xe-dowcwXkO8rDH2reMzGadUMSq5ZtV=23FP4virt+DUQ@mail.gmail.com>
References: <20160830075600.11559-1-andrew@aj.id.au>
 <20160830075600.11559-5-andrew@aj.id.au>
 <CACPK8Xe-dowcwXkO8rDH2reMzGadUMSq5ZtV=23FP4virt+DUQ@mail.gmail.com>
Message-ID: <1473800295.8689.295.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-09-13 at 22:11 +0930, Joel Stanley wrote:
> It's not clear that all systems use these pins in that way. I will
> not
> include this one for now.

Well, it has VGA so the VGA hsync, vsync and DDC should be there at
least...

Ben.
