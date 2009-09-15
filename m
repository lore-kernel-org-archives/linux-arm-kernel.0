From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 16 Sep 2009 00:03:02 +0200
Subject: [PATCH 2.6.31] ixp4xx: arch_idle() documentation fixup
In-Reply-To: <200909102256.n8AMusBE014917@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Fri, 11 Sep 2009 00:56:54 +0200 (MEST)")
References: <200909102256.n8AMusBE014917@pilspetsen.it.uu.se>
Message-ID: <m3bplbdfxl.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> So this patch:
> - adds a comment before the #if 0 to explain why
>   cpu_do_idle() mustn't be called on ixp4xx
> - removes the obsolete test of hlt_counter and the
>   obsolete parameter to cpu_do_idle()

Thanks a lot, Mikael.

> This is purely a documentation fixup and changes no
> generated code. Even so, it has been tested on an
> ixp420 machine (ds101).

:-)
-- 
Krzysztof Halasa
