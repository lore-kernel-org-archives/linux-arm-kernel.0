From: plyatov@gmail.com (Igor Plyatov)
Date: Wed, 08 Dec 2010 22:29:28 +0300
Subject: [PATCH v2] mach-at91: Support for gms board added
In-Reply-To: <20101208140313.GD3429@game.jcrosoft.org>
References: <1291732927-9429-1-git-send-email-plyatov@gmail.com>
	<4CFE90CA.9050004@bluewatersys.com> <4CFF47A0.8010208@atmel.com>
	<20101208140313.GD3429@game.jcrosoft.org>
Message-ID: <1291836568.15873.58.camel@homepc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Christophe,

> > I have exactly the same feeling as Ryan. We should make sure 
> > to factorize as much code as possible for maintenance reasons.
> > 
> > If you need to distinguish between board features, you can 
> > pass information in system_rev as implemented in this 
> > board merging commit:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a6e016f19d393fbe4e040bee8155b03b840fa689
> I agree with nico not need to have a new board for just few difference
> 
> and as we start with the rm9200 we will reduce the number of defconfig first per soc and then for the all sam9

I think it does not make sence to invent new machine for each new
carrier board. Better to have a kernel configuration options which will
allow to select required carrier board.

Best regards!
--
Igor Plyatov
