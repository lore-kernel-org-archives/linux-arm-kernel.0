From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Dec 2014 11:49:45 +0100
Subject: [PATCH] clk: sunxi: Fix factor clocks usage for sun9i core clocks
In-Reply-To: <CAGb2v67jri1ahFtf4yRviQ80zpyjStJfe+SNJm3JOysfRv=R_g@mail.gmail.com>
References: <1417080570-5099-1-git-send-email-wens@csie.org>
 <20141130212920.GA25249@lukather>
 <CAGb2v67jri1ahFtf4yRviQ80zpyjStJfe+SNJm3JOysfRv=R_g@mail.gmail.com>
Message-ID: <20141201104945.GG25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 11:30:54AM +0800, Chen-Yu Tsai wrote:
> >> This patch is for 3.20.
> >>
> >> A bit of boiler plate code for each clock provider.
> >> Maybe we should add a local helper or something?
> >
> > Well, isn't that expected since we actually just moved it out?
> 
> I'll look into making a nice macro for this.

Please don't. We removed it from the common code for a reason, there's
no point in putting it back.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/a0d30058/attachment.sig>
