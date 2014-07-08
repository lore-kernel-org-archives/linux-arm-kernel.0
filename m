From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Jul 2014 10:06:36 +0200
Subject: [PATCH 09/18] AT91: Call at91_register_devices in the board files
In-Reply-To: <20140707184239.GI9558@ns203013.ovh.net>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404396906-25194-15-git-send-email-maxime.ripard@free-electrons.com>
 <D103F102-4B04-4CC6-8F20-58CEB0EC8E36@jcrosoft.com>
 <20140703145222.GE31996@lukather>
 <20140707184239.GI9558@ns203013.ovh.net>
Message-ID: <20140708080636.GK13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 08:42:39PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:52 Thu 03 Jul     , Maxime Ripard wrote:
> > Hi,
> > 
> > On Thu, Jul 03, 2014 at 10:29:58PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > no do this at SoC level
> > 
> > Since it has to be done at init_machine, I don't see any other easy
> > way to do this at the SoC level.
> > 
> > What is your suggestion?
> 
> do it earlier as there is not driver it will not change anything

My question remains. When should I do so?

at91_initialize is too early to register any devices.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/d18dec9c/attachment-0001.sig>
