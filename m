From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Mar 2014 11:11:39 +0100
Subject: [linux-sunxi] Re: [PATCH v2 6/8] ARM: sunxi: dt: Add
 x-powers-axp209.dtsi file
In-Reply-To: <20140322143157.GB20668@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-7-git-send-email-carlo@caione.org>
 <20140318090450.GV27873@lukather>
 <20140322143157.GB20668@localhost.fastwebnet.it>
Message-ID: <20140325101139.GB6120@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 03:31:57PM +0100, Carlo Caione wrote:
> > > +	compatible = "x-powers,axp209";
> > > +	interrupt-controller;
> > > +	#interrupt-cells = <1>;
> > 
> > However, I'd move this out of it, and in the board file, so that we
> > actually get an idea by looking at the board DTS of what device we are
> > actually registering at this given address, and what it's capable of.
> 
> Do you mean the whole dtsi or just those three lines?

Just those three lines.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/9be5dc49/attachment.sig>
