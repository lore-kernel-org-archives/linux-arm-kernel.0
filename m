From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jun 2016 14:30:53 +0200
Subject: [PATCH 01/20] clk: fixed-factor: Pass clk rates change to the
 parent
In-Reply-To: <1463402840-17062-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160610123053.GW5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 02:47:01PM +0200, Maxime Ripard wrote:
> A fixed factor clock, if it needs to change its rate, by definition do not
> have any choice but to modify its parent rate.
> 
> Add the CLK_SET_RATE_PARENT flag to that clock so that it can happen
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Mike, Stephen, any comments on this one?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/5356765a/attachment.sig>
