From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 15 May 2013 13:44:28 +0100
Subject: v3.10-rc1: compile problem in arch/arm/common/mcpm_platsmp.c
In-Reply-To: <20130515123640.GA9066@amd.pavel.ucw.cz>
References: <20130515123640.GA9066@amd.pavel.ucw.cz>
Message-ID: <1368621868.5583.6.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-05-15 at 14:36 +0200, Pavel Machek wrote:
> Hi!
> 
> I'm trying to switch to v3.10-rc1, and got following:
> 
> arch/arm/common/mcpm_platsmp.c: In function 'mcpm_secondary_init':
> arch/arm/common/mcpm_platsmp.c:52:2: error: implicit declaration of
> function 'gic_secondary_init' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/common/mcpm_platsmp.o] Error 1
> make: *** [arch/arm/common] Error 2
> make: *** Waiting for unfinished jobs....

This has already been hit by others and there is a patch in the
pipeline, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/167586.html

-- 
Tixy
