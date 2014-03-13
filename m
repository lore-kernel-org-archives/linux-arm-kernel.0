From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 12:15:58 +0100
Subject: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
In-Reply-To: <20140312180751.GC1484@spo001.leaseweb.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140303104042.GU607@lukather>
 <20140311205405.GA10228@spo001.leaseweb.com>
 <20140312091649.GU2815@lukather>
 <20140312180751.GC1484@spo001.leaseweb.com>
Message-ID: <20140313111558.GH2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, Mar 12, 2014 at 07:07:51PM +0100, Wim Van Sebroeck wrote:
> > > I'm OK with the patches, but what is the preferred way to get them upstream?
> > > via watchdog tree or via arch/soc tree?
> > 
> > Since it touches the machine restart code, I'd prefer to merge it
> > myself if it's ok?
> 
> No Problem. You have my Acked-by.

Actually, I only have to keep together patches 2 and 3. Could you
merge the first one? I'll handle the two others.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/ca831906/attachment.sig>
