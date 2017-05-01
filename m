From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 1 May 2017 06:44:28 +0200
Subject: [PATCH] [media] pxa_camera: fix module remove codepath for v4l2
 clock
In-Reply-To: <87a87111s6.fsf@belgarion.home>
References: <4391b498-0a75-ff42-6a7e-65aef0fada07@tul.cz>
 <87efwd1wus.fsf@belgarion.home> <c95ef700-d34d-5aa2-ef92-ad1aa7dd5a0d@tul.cz>
 <87a87111s6.fsf@belgarion.home>
Message-ID: <b9c94483-5990-9a3f-31d3-7b65e5ccac44@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 28.4.2017 v 08:31 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> I will post some other bugfixes (and feature adding) for pxa_camera soon. Do you wish to be CC'd? 
>>
>> P.S. Who is the the maintainer of pxa_camera BTW? Still Guennadi Liakhovetski?
> Euh no, that's me.

OK ... so when I remove the ov9640 driver from soc_camera (palmz72 and magician used it with soc_camera+pxa_camera) does that mean I will be its maintainer?

Petr
