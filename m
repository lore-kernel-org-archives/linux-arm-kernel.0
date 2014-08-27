From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 27 Aug 2014 20:14:01 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <20140827175243.GJ13850@arm.com>
References: <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826101107.GC32315@leverpostej>
 <20140827103432.64927C409CB@trevor.secretlab.ca>
 <20140827144403.GB13850@arm.com> <53FE05AE.9000406@wwwdotorg.org>
 <53FE07BE.7000809@ahsoftware.de> <53FE0966.5020206@wwwdotorg.org>
 <20140827175243.GJ13850@arm.com>
Message-ID: <53FE1FE9.6070109@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.08.2014 19:52, schrieb Catalin Marinas:

>> Irrespective though, a new kernel needs to work against an old DT,
>
> I fully agree. But we shouldn't really extend the "old DT" statement to
> a new ARMv8 SoC ;).

Or any new v7 SoC. And even poor users of current ARM HW do want use 
their HW. And they don't care if they have to change the DT if they 
finally are able to use their board, which happens seldom enough. (I'm 
not speaking about companies which are able to spend many man-years to 
fix one kernel version for use with one specific HW).

Regards,

Alexander Holler
