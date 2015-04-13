From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:46:16 +0200
Subject: [GIT PULL RESEND] pxa: for-next v4.1
In-Reply-To: <87vbh2pi3m.fsf@free.fr>
References: <87ioe08y4b.fsf@free.fr> <87vbh2pi3m.fsf@free.fr>
Message-ID: <201504140146.16720.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 April 2015, Robert Jarzmik wrote:
> This is the pxa changes for v4.1 cycle.
> 
> The main and only feature is the conversion of all pxa variants to clock
> framework. This encompasses pxa25x, pxa27x and pxa3xx, for all boards.
> 
> This should be a disruptive cycle in the normally quiet pxa history, as
> the change can break any platform, and the test were performed on only 4
> boards (lubbock, zylonite, mioa701, cm-x300).

Hi Robert,

We screwed up here and missed the pull requests earlier. I thought
about putting them in the late branch now, but as they had no time in
linux-next before the merge window, I think it's way too risky.

Please submit again after 4.1-rc1. Feel free to nag us much earlier
if you get the impression that we missed something you wanted us
to pick up.

	Arnd
