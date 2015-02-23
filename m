From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 23 Feb 2015 17:56:14 +0100
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <54EB4E9B.6010001@free-electrons.com>
 <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
Message-ID: <20150223175614.5c8462de@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Mon, 23 Feb 2015 10:50:26 -0600, Rob Herring wrote:

> Not exactly, stdout-path allows for removing "console" from the
> command line. earlyprintk is a debug/developer option, so it should
> not be in a default command line IMO.
> 
> So bootargs should be removed entirely.

Ok, will be in v3, rebased on top of 4.0-rc1.

I also noticed another issue in the patch series: missing Armada 375
UART aliases. I'll fix that up as well when sending v3.

Thanks for the feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
