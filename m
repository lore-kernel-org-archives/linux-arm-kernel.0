From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Dec 2016 17:10:59 +0000
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <20161211070104.GB3035@afzalpc>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc> <878trntrig.fsf@dell.be.48ers.dk>
 <20161211070104.GB3035@afzalpc>
Message-ID: <20161213171059.GA14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2016 at 12:31:04PM +0530, Afzal Mohammed wrote:
> And in buildroot,
> couldn't see Cortex R option in menuconfig, and selecting Cortex-A's
> excludes flat binary target & presents only with ELF.

That's something which has changed in the kernel - you can now build
for MMUful platforms, and run flat binaries.  See commit d782e426b835
("ARM: 8594/1: enable binfmt_flat on systems with an MMU").

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
