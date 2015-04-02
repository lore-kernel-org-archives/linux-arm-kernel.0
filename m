From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Apr 2015 11:22:59 +0200
Subject: [PATCH] ARM: dts: sun7i: Add Goodix GT911 nodes for Wexler TAB7200
In-Reply-To: <20150331221420.3b65d2540c7dbe1d12611e12@gmail.com>
References: <1427789897-4085-1-git-send-email-mamlinav@gmail.com>
 <20150331144338.GG23664@lukather>
 <20150331221420.3b65d2540c7dbe1d12611e12@gmail.com>
Message-ID: <20150402092259.GK23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 10:14:20PM +0300, Aleksei Mamlin wrote:
> On Tue, 31 Mar 2015 07:43:38 -0700
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > On Tue, Mar 31, 2015 at 11:18:17AM +0300, Aleksei Mamlin wrote:
> > > This patch adds nodes for the Goodix GT911 touchscreen controller found
> > > on the Wexler TAB7200 tablet. Controller uses one of following I2C
> > > addresses: 0x5d or 0x14, so just add two nodes.
> > 
> > In which case are these different addresses encountered? Different
> > revisions of the same board?
>
> According to the datasheet it is a feature of the controller. 
> The address(0x5d or 0x14) can be configured using a reset sequence,
> which has not yet been implemented in the driver.

Which address is set up by the bootloader then?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/4c8233b4/attachment.sig>
