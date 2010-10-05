From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 06 Oct 2010 01:27:21 +0200
Subject: [PATCH 1/2] ARM: S3C64XX: Add suspend support
In-Reply-To: <AANLkTi=CH6BJZDYsCHXmcYAVuu-LTsqjKXUVGnBAikiN@mail.gmail.com>
References: <cover.1286319272.git.mcuelenaere@gmail.com>	<1fa4a7a39d9fd48b8329e1a1077a65adb96475b5.1286319272.git.mcuelenaere@gmail.com>
	<AANLkTi=CH6BJZDYsCHXmcYAVuu-LTsqjKXUVGnBAikiN@mail.gmail.com>
Message-ID: <4CABB459.6070209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 06-10-10 01:23, Kyungmin Park schreef:
> Hi,
>
> I agree your approach, put the common features in common place.
> but Samsung maintainers insist put these at each machine file at current time.
>
> So move this to the each machines for their tastes.
I did it that way first, but then wondered why this wasn't done for all boards.

When looking at some S3C24XX boards, you'll see that these need changes to the
bootloader to support suspend; but IIRC this isn't needed for S3C64XX so I think
this can be safely enabled for all S3C64XX boards?

-- 
Maurus Cuelenaere
