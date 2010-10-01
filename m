From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Oct 2010 09:57:37 -0700
Subject: multiple linux-next OMAP3 build errors
In-Reply-To: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Message-ID: <20101001165737.GT3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [101001 08:49]:
> hi,
> 
> I've been building linux-next for a while now and keep getting these
> build errors, just posting them here in case not all are known. Not
> familiar enough with that code to send patches unfortunately.
> 
>   AS      arch/arm/mm/proc-v7.o
> arch/arm/mm/proc-v7.S: Assembler messages:
> arch/arm/mm/proc-v7.S:363: Error: undefined symbol `PMD_FLAGS' in operation

This I've already fixed in omap-testing branch. Should get merged into
for-next soonish.

Regards,

Tony 
