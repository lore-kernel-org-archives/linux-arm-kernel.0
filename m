From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:30 +0000
Subject: ARM big-endian on current kernels for linux-3.8
Message-ID: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been working on getting big-endian kernels working, mainly from
little-endian boot envrionments. The following patch series is what I
have been working on, mainly on the highbank and axp systems.

Feedback and testing is welcome.

I have published these on git.baserock.org

	git://git.baserock.org/delta/linux baserock/arm/bjdooks/be8_v1
	git://git.baserock.org/delta/linux baserock/arm/bjdooks/linux37-be8-1

The second is a backport of the v3.8-rc6 work due to problems with
booting on the highbank which Rob is resolving at the moment.
