From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 18:08:36 +0200
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <573C8B55.3030805@suse.de>
References: <1463576010-115428-1-git-send-email-agraf@suse.de>
 <20160518151958.GH22378@e104818-lin.cambridge.arm.com>
 <573C8B55.3030805@suse.de>
Message-ID: <3270693.WrXnxabe9J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 May 2016 17:33:41 Alexander Graf wrote:
> >
> >> IIRC we don't own EL3 on there.
> > Then how do you switch to AArch64?
> 
> You write into config.txt that you want to boot into AArch64 EL2 and the 
> raspberry pi firmware takes care of the rest.
> 
> 

Have you tried telling the firmware that you'd like to boot into AArch64 EL3? ;-)

	Arnd
