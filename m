From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 07 Oct 2010 00:27:58 +0200
Subject: [PATCH 1/2] ARM: S3C64XX: Add suspend support
In-Reply-To: <4CACF6B8.9030304@fluff.org>
References: <cover.1286319272.git.mcuelenaere@gmail.com>	<1fa4a7a39d9fd48b8329e1a1077a65adb96475b5.1286319272.git.mcuelenaere@gmail.com>
	<AANLkTi=CH6BJZDYsCHXmcYAVuu-LTsqjKXUVGnBAikiN@mail.gmail.com>
	<4CACF6B8.9030304@fluff.org>
Message-ID: <4CACF7EE.8090605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 07-10-10 00:22, Ben Dooks schreef:
> I would still prefer each machine that can do pm to call s3c_pm_init()
> in their setup code to ensure that we don't enable pm on a machine with
> possibly incomplete support (especially as PM can be one of the more
> difficult things to debug).

Ok, will resend this with the call only added to mach-smartq.c

-- 
Maurus Cuelenaere
