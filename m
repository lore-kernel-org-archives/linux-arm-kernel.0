From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 10:11:06 +0200
Subject: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
In-Reply-To: <20130611182121.GA3376@katana>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130605133945.GA2934@katana> <20130605213144.GB14209@lukather>
 <20130611182121.GA3376@katana>
Message-ID: <20130612081106.GA16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Jun 11, 2013 at 08:21:22PM +0200, Wolfram Sang wrote:
> The thing is: If there is a bug/errata found in one driver, it goes
> unnoticed that it probably should be fixed in the other, too. This is
> why sharing logic is a good thing from a maintenance view.

Yes, I definitely understand that.

> Register offsets are annoying, but one can handle them. There are
> examples in the kernel tree. If some registers are totally different
> they often can be encapsulated in specific functions processing them.
> 
> So, I'd like to ask you if you can prepare a list of what would be
> needed to merge this support into mv64xxx? Then I get a better picture
> of what way to go. Can you do this?

I had some time to work on this, I sent you the patches. Except for the
register offset parts, the logic of the driver itself needed no
modifications, so the only "big" change is to pass the register
structure somehow.

Anyway, I just sent to you the patches I had.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
