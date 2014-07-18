From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 18 Jul 2014 10:55:49 +0200
Subject: ASoC: samsung: MACH_SMDKC100
In-Reply-To: <1404288063.12021.13.camel@x220>
References: <1404288063.12021.13.camel@x220>
Message-ID: <1405673749.2155.5.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Wed, 2014-07-02 at 10:01 +0200, Paul Bolle wrote:
> Your commit 52ad6582ceb2 ("ARM: S5PC100: no more support S5PC100 SoC"
> landed in next-20140702. It removed the Kconfig symbol MACH_SMDKC100
> (and a lot of other stuff).
> 
> Is the trivial patch to also remove the last two references to
> MACH_SMDKC100 from sound/soc/samsung/Kconfig/ queued somewhere? I don't
> think it was part of the series that included the above commit.

Have you had time to look at this? Those last two references to
MACH_SMDKC100 can still be seen in next-20140718.


Paul Bolle
