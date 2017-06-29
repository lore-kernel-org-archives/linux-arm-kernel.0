From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 09:48:25 +0200
Subject: arm64: build is broken on next-20170609 with merge-commit
 9afca2c4e379 (arm64: allwinner: sun50i-a64: add dwmac-sun8i Ethernet driver)
In-Reply-To: <20170628160711.08763ee7@canb.auug.org.au>
References: <20170609124325.p7b6fhdbwtki4w2z@yury-thinkpad>
 <20170610092944.4022d550@canb.auug.org.au>
 <20170628160711.08763ee7@canb.auug.org.au>
Message-ID: <20170629074825.pgeg2ut3nb3tj36u@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 28, 2017 at 04:07:11PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> [Yes, top posted :-)]
> 
> With the merge window approaching, this is just a reminder that this
> merge problem still exists.  I assume that the sunxi tree will be
> merged into the arm-soc tree before going to Linus.

It's already been merged in arm-soc. I haven't had any news from Dave
on this despite my mails, so I don't really know how to solve this.

Those patches really should never have been in net-next in the first
place.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/bba04f9e/attachment.sig>
