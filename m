From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 22 May 2016 21:22:19 +0200
Subject: [PATCH 08/16] clk: sunxi-ng: Add M-factor clock support
In-Reply-To: <CAGb2v67wqsLR9QoMihSS6dkqqtyed=HqyBMJEp4adNm_xF-26Q@mail.gmail.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-9-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67wqsLR9QoMihSS6dkqqtyed=HqyBMJEp4adNm_xF-26Q@mail.gmail.com>
Message-ID: <20160522192219.GZ27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 22, 2016 at 01:09:09AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Introduce support for clocks that divide by a linear factor.
> 
> I think we can have just one implementation for single divide factor
> (either P or M)
> clocks, using the CCF divider helpers. Even the divider table clock
> could be merged
> in.

This is a good point, I'll merge the drivers.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160522/0aa79e59/attachment.sig>
