From: martinwguy@gmail.com (Martin Guy)
Date: Tue, 20 Apr 2010 11:33:06 +0100
Subject: [PATCH] ep93xx: move physmap flash registration into core.c
In-Reply-To: <0D753D10438DA54287A00B0270842697636D62B066@AUSP01VMBX24.collaborationhost.net>
References: <AcrcNxXi/1OpCfUUTQ2+Xkz9P4CSMQ==>
	<0D753D10438DA54287A00B0270842697636D62B066@AUSP01VMBX24.collaborationhost.net>
Message-ID: <t2h56d259a01004200333gfc5b6307vb34c20e60db28aa1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/15/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
> Create a core.c __init function to handle the physmap flash
>  registration for all the ep93xx platforms.  Also, modify all
>  the ep93xx platforms to use this new function.
>
>  This simplifies all the ep93xx platform init code and removes
>  all the static variables that would exist in a unified kernel
>  supporting multiple ep93xx platforms.
>
>  Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>  Cc: Ryan Mallon <ryan@bluewatersys.com>

Tested on the Sim.One platform - works fine

Acked-by: Martin Guy <martinwguy@gmail.com>

    M
