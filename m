From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Sep 2014 13:41:40 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140929220250.GD5599@skynet.be>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be>
Message-ID: <20140930124140.GC4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 12:02:50AM +0200, Luc Verhaegen wrote:

> 2) Simplefb will only have a single user: the rpi. As the only other 
> users i can think of, which does not have a full driver and which does 
> not have clocks automatically disabled, are discrete cards. And they do 
> not really tend to happen with dt or platform devices.

I thought the goal was for other platforms to use simplefb while waiting
for the real drivers to be loaded (so you can get get console output as
early as possible from a built in driver for example)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/0e1ccc26/attachment.sig>
