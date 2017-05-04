From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 May 2017 16:40:10 +0200
Subject: [PATCH v2 02/10] pinctrl: sunxi: add definitions for add A20 and
 R40 support to A10 driver
In-Reply-To: <318E9984-9F5A-41C3-A3E0-52D5ECA05212@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-3-icenowy@aosc.io>
 <20170504140431.zhpcxvphxnxj7ipq@lukather>
 <318E9984-9F5A-41C3-A3E0-52D5ECA05212@aosc.io>
Message-ID: <20170504144010.lco2r6jviff63bcd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 10:07:47PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?5?4? GMT+08:00 ??10:04:31, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >On Thu, May 04, 2017 at 09:49:58PM +0800, Icenowy Zheng wrote:
> >> Allwinner A10, A20 and R40 SoCs have similar GPIO layout.
> >> 
> >> Add SoC definitions in pinctrl-sunxi.h, in order to merge A20 support
> >> into A10 driver, and add R40 support into it.
> >
> >While your commit log is good, the commit title is misleading since
> >you're not adding it to the A10 driver. You just adding SoC IDs
> >definitions
> 
> Is "pinctrl: sunxi: Add SoC ID definitions for A10, A20 and R40 SoCs" OK?

Yep, it is, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170504/d0338558/attachment.sig>
