From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 28 Aug 2014 08:50:36 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53FE0966.5020206@wwwdotorg.org>
References: <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com> <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826101107.GC32315@leverpostej>
 <20140827103432.64927C409CB@trevor.secretlab.ca>
 <20140827144403.GB13850@arm.com> <53FE05AE.9000406@wwwdotorg.org>
 <53FE07BE.7000809@ahsoftware.de> <53FE0966.5020206@wwwdotorg.org>
Message-ID: <53FED13C.4070606@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.08.2014 18:37, schrieb Stephen Warren:

> Of course, there are probably cases where we could/should add some more
> phandles/... and likewise cases where we shouldn't. That's why detailed
> research is needed.

Just because I'm curious, I wonder how this research does or shoud look 
like.

Defered probes did come to light with 3.4, that was more than 2 years 
ago. Ok, most people (like me) just noticed it during the last months 
when they switched to DT and have run into a problem (the deferred probe 
mechanism is an error-message killer), but some must have seen it 
already 2 years ago.

And I wonder how the ACPI world solves that problem. My guess would be 
hardcoded stuff in the firmware-blob (BIOS), just like it happened with 
board files, but I've never seen BIOS code and my knowledge about ACPI 
is almost zero. ;)

Regards,

Alexander Holler
