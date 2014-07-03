From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Jul 2014 16:52:22 +0200
Subject: [PATCH 09/18] AT91: Call at91_register_devices in the board files
In-Reply-To: <D103F102-4B04-4CC6-8F20-58CEB0EC8E36@jcrosoft.com>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404396906-25194-15-git-send-email-maxime.ripard@free-electrons.com>
 <D103F102-4B04-4CC6-8F20-58CEB0EC8E36@jcrosoft.com>
Message-ID: <20140703145222.GE31996@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 03, 2014 at 10:29:58PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> no do this at SoC level

Since it has to be done at init_machine, I don't see any other easy
way to do this at the SoC level.

What is your suggestion?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/0de9bd37/attachment-0001.sig>
