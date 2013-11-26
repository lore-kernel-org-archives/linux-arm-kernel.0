From: sre@debian.org (Sebastian Reichel)
Date: Tue, 26 Nov 2013 15:25:30 +0100
Subject: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in
 DT only mode
In-Reply-To: <52949790.1010900@epfl.ch>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <52949790.1010900@epfl.ch>
Message-ID: <20131126142530.GA32406@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 26, 2013 at 01:44:00PM +0100, Florian Vaussard wrote:
> IMHO one remaining issue is the missing binding for the camera interface
> (ISP). I saw recently an RFC from Sebastian Reichel to add the necessary
> binding [1], but this work will probably take some time. So probably a
> quirk is necessary here to bring up this IP.

My DT patches for omap3-isp won't be ready for 3.14.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/4bf2260e/attachment.sig>
