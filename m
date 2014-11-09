From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 09 Nov 2014 19:19:33 +0100
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
In-Reply-To: <CALT56yOU=cqczdEs=FOgoWUHev1A0gihEpV-XsD5_g_ECz6+Qg@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sun, 9 Nov 2014 20:11:27
 +0400")
References: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
 <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
 <87lhnlwqm4.fsf@free.fr>
 <CALT56yNOXq-ssvsjafz=ae+uWv1GyscoQ3RQ_h--i740zm4trA@mail.gmail.com>
 <8761epwgni.fsf@free.fr>
 <CALT56yOU=cqczdEs=FOgoWUHev1A0gihEpV-XsD5_g_ECz6+Qg@mail.gmail.com>
Message-ID: <87fvdsuthm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> 2014-11-09 0:01 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Tested-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
OK, that's really great, thanks for your testing effort.
I'll digest the clk_summary output next week to cross-check everything is in
order.

> Could you please also include a revert of
> 23c4a3a5212701ad34bd30591fa33d7bacef9c5f
> into your branch? Otherwise pxa27x is broken in your tree.
Done.

I will release v2 of this serie very soon now as the fixes for at least 2
pxa25x platforms are identified and done.

Cheers.

-- 
Robert
