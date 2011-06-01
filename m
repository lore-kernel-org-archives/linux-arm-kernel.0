From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 01 Jun 2011 17:08:59 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110530084307.GA28953@riccoc20.at.omicron.at> (Richard
	Cochran's message of "Mon, 30 May 2011 10:43:07 +0200")
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
Message-ID: <m3d3ixtwqc.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran <richardcochran@gmail.com> writes:

> Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
>
>    clocksource: convert ARM 32-bit up counting clocksources
>
> broke the build for ixp4xx and made big endian operation impossible.
> This commit restores the original behaviour.

Thanks.

I can't ATM do anything Linux-related but will do ASAP. Two-three weeks
I hope.
-- 
Krzysztof Halasa
