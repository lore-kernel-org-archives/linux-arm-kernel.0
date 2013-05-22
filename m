From: neidhard.kim@lge.com (Jongsung Kim)
Date: Wed, 22 May 2013 10:52:22 +0900
Subject: [PATCH] ARM: bcm2835: override the HW UART periphid
In-Reply-To: <519C22CB.5040009@wwwdotorg.org>
References: <519AD82A.6090809@wwwdotorg.org>
 <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
 <519BA209.6050407@wwwdotorg.org> <519C22CB.5040009@wwwdotorg.org>
Message-ID: <013101ce568f$002d6490$00882db0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> :
> Looking at the TRM, it seems this is really the only change, according
> to the changelog in the documentation (although it's a little difficult
> to tell since the document seems to have a bunch of changes that
presumably
> don't affect behaviour). So, faking the periphid seems OK.
>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>
> Let's apply for 3.10.

Thank you, Stephen.
