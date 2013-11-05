From: timur@tabi.org (Timur Tabi)
Date: Tue, 05 Nov 2013 07:26:18 -0600
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <5278F1FA.1060706@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Li Xiubo wrote:
> But fsl-ssi.o and fsl-spdif.o is based PowrePC platform? Which we can see from the comments.

fsl_ssi was originally PPC-only, but it now supports PPC and ARM.  You 
can see that from the git history.

If there are any comments that say PPC but are not PPC-specific, that 
should be fixed.
