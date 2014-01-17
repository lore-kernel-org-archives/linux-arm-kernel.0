From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jan 2014 10:02:14 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
Message-ID: <20140117090214.GA2348@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote :
> "for SDIO slots" is somewhat misleading; nearly all controllers only
> do one slot/device per controller. The designware controller can do
> multiple slots, and that adds a bit of driver and binding complexity
> for something that seemingly not a single vendor has actually
> implemented.
> 
> So we can likely assume to keep these reset/power/clock lines per host
> controller, no need to add a slot construct.
> 

Actually, the atmel chips have two slots per controller so it would
probably be better to think about that now.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/7e539c1a/attachment.sig>
