From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2017 16:24:38 +0000
Subject: [Patch v3 1/2] arm: kernel: Add SMC structure parameter
In-Reply-To: <20170119161658.GC9631@hector.attlocal.net>
References: <1484173918-25090-1-git-send-email-andy.gross@linaro.org>
 <1484173918-25090-2-git-send-email-andy.gross@linaro.org>
 <20170119144008.GA27312@n2100.armlinux.org.uk>
 <20170119154506.GB9631@hector.attlocal.net>
 <20170119154818.GE27312@n2100.armlinux.org.uk>
 <20170119161658.GC9631@hector.attlocal.net>
Message-ID: <20170119162438.GF27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 10:16:58AM -0600, Andy Gross wrote:
> On Thu, Jan 19, 2017 at 03:48:18PM +0000, Russell King - ARM Linux wrote:
> > Please add that detail to the kerneldoc comments for the structure
> > concerning state.a6.  It's important that such information is not
> > lost in the depths of history.
> 
> For documentation, should I split out the union separately?  I don't see any
> good examples for documenting union members in unions defined inside structures.

Good question - I don't know.

 @state.a6: blah

would seem to be a logical and unambiguous way to document it, but I
don't know whether kerneldoc will accept that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
