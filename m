From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Feb 2017 17:44:57 +0100
Subject: [PATCHv2 net-next 01/16] dt-bindings: net: update Marvell PPv2
 binding for PPv2.2 support
In-Reply-To: <20170107093228.GI14217@n2100.armlinux.org.uk>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170107093228.GI14217@n2100.armlinux.org.uk>
Message-ID: <20170202174457.17ceabe9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 7 Jan 2017 09:32:28 +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 28, 2016 at 05:46:17PM +0100, Thomas Petazzoni wrote:
> > @@ -31,7 +43,7 @@ Optional properties (port):
> >    then fixed link is assumed, and the 'fixed-link' property is
> >    mandatory.  
> 
> Not directly related to this patch, but this context is wrong.  The
> PP2 driver _requires_ a PHY.  It doesn't support fixed-link in its
> current form.  I think the DT binding describes an expectation of
> a future driver.
> 
> The side effect is that if trying to use a fixed-link on any port,
> the ethernet driver fails to probe.

Correct. I will send a patch to adjust the Device Tree binding
documentation accordingly. Thanks for noticing this mistake!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
