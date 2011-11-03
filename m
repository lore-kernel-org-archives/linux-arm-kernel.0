From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 03 Nov 2011 20:34:13 +0100
Subject: [PATCH] pxa/mioa701: remove machine restart and halt code
Message-ID: <87ehxpvw3u.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Eric,

I have this patch which fixes shutdown/reboot path in mioa701 board. It follows
Russell's comments on mioa701 shutdown handling in [1].

Could I have your ack here ? As this depends on Russell's cleanup patch
(soft_reboot machine descriptor field), I'll ask you not to take that patch, but I
will submit it instead to Russell's patch tracking system.

Cheers.

-- 
Robert

[1]:
http://lists.arm.linux.org.uk/lurker/message/20111101.160731.30dcc778.en.html


--- cut here ---
