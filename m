From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 16 Jan 2013 16:49:13 +1300
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
In-Reply-To: <20130116141411.8fadedee54ed35dc0eddd288@canb.auug.org.au>
References: <20130116141411.8fadedee54ed35dc0eddd288@canb.auug.org.au>
Message-ID: <1358308153.32106.8.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 14:14 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tegra tree got a conflict in
> drivers/clocksource/Makefile between commit ff7ec345f0ec ("timer: vt8500:
> Move timer code to drivers/clocksource") from the arm-soc tree and commit
> ac0fd9eca3ba ("ARM: tegra: move timer.c to drivers/clocksource/") from
> the tegra tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 

I don't know about everyone else, but I feel the preference should be to
keep things alphabetized where possible to help avoid with merge
conflicts later on. This is always a problem when we start tacking
things on the end of lists.

I realise this Kconfig is not alphabetized anyway, but it's never too
early to start on the 'right' path.

Regards
Tony P
