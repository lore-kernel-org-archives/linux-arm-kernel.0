From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 10:30:43 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <883408ea-bb2e-4f93-a2e6-40efad4ee42f@googlegroups.com>
References: <5627BDB6.6020501@gmail.com>
 <883408ea-bb2e-4f93-a2e6-40efad4ee42f@googlegroups.com>
Message-ID: <20151022083043.GP10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 22, 2015 at 01:21:26AM -0700, josef.gajdusek at gmail.com wrote:
> Hi everyone,
> 
> I might be missing something, but why is the PL* GPIO bank not
> declared here?

Because it's in the PRCM. This one was adding support for the main
port controller.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/fab2d987/attachment.sig>
