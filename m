From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Feb 2017 21:31:29 +0100
Subject: [PATCH] ARM: dts: kirkwood: Fix SATA pinmux-ing for TS419
In-Reply-To: <1487611358.2885.3.camel@decadent.org.uk>
References: <20170218003251.GC4152@decadent.org.uk>
 <20170220135955.63fbcaa3@free-electrons.com>
 <1487608825.2885.1.camel@decadent.org.uk>
 <20170220175049.45f319bb@free-electrons.com>
 <1487611358.2885.3.camel@decadent.org.uk>
Message-ID: <20170220213129.70273362@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 20 Feb 2017 17:22:38 +0000, Ben Hutchings wrote:

> You mean, define additional pinmux nodes and override the pinctrl-0
> property of &sata?  More like this:

Yes, exactly.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
