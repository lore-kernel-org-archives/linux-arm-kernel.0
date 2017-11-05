From: mylene.josserand@free-electrons.com (Mylene JOSSERAND)
Date: Sun, 5 Nov 2017 17:37:26 +0100
Subject: [PATCH] clk: sunxi-ng: a83t: Fix i2c buses bits
In-Reply-To: <20171103151100.GR11011@codeaurora.org>
References: <20171103105747.26335-1-mylene.josserand@free-electrons.com>
 <20171103151100.GR11011@codeaurora.org>
Message-ID: <20171105173726.7be83f08@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Fri, 3 Nov 2017 08:11:00 -0700,
Stephen Boyd <sboyd@codeaurora.org> a ?crit :

> On 11/03, Myl?ne Josserand wrote:
> > i2c1 and i2c2 bits for CCU are not bit 0 but bit 1 and bit 2.
> > Because of that, the i2c0 (bit 0) was not correctly configured.
> > Fixed the correct bits for i2c1 and i2c2.
> > 
> > Signed-off-by: Myl?ne Josserand
> > <mylene.josserand@free-electrons.com> ---  
> 
> Please add a Fixes tag.
> 

Sure, I will resend the patch with a Fixes tag.

Thank you,

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
