From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 10:40:16 +0000
Subject: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
In-Reply-To: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201208231040.16702.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Tony Prisk wrote:
> Patchset based on Arnd's arm-soc/for-next branch.
> 
> 
> Could I get this reviewed, hopefully for inclusion into v3.7.

I can take them into the arm-soc tree if there are no new comments.
For the last two patches, you need to get an Acked-by comment from the
gpio and clk maintainers, respectively, or you should send them
the patches for inclusion in those subsystem trees.

	Arnd
