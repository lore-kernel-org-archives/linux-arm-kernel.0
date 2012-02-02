From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Feb 2012 13:46:08 +0000
Subject: [PATCH 1/4] Remove Telechips ARM subarch from MAINTAINERS
In-Reply-To: <20120202104541.GB1643@atrey.karlin.mff.cuni.cz>
References: <20111222211948.GA1201@local>
 <20120103170824.GA2914@n2100.arm.linux.org.uk>
 <20120202104541.GB1643@atrey.karlin.mff.cuni.cz>
Message-ID: <201202021346.08740.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 February 2012, Pavel Machek wrote:
> > On Thu, Dec 22, 2011 at 10:22:40PM +0100, Hans J. Koch wrote:
> > > 
> > > The AMR subarchitecture for Telechips SoCs is completely removed,
> > 
> > Apart from this spelling mistake, the rest look fine.  Do you want to
> > send me a pull request with that fixed?
> 
> Normally features are removed using feature-removal-schedule.txt. No
> maintainer is not a reason to remove it like this.

Code that doesn't build and hasn't worked for a long time is enough
reason IMHO. Note that the tcc platform was for the old arm926 based
tcc8000, not the newer ARM11 based tcc89xx/91xx/92xx/93xx or even the
Cortex-A8 based tcc88xx.

Telechips themselves seem to have given up on the ARM9 based products
(see [1]) and there is practically no code reuse between what was there
in v3.2 and what would have to get added to support the newer producs.

Is there any particular reason why you are interested in keeping
the code around? 

	Arnd

[1] https://www.telechips.com/technical_support/kor/opensource/opensource_list.asp
