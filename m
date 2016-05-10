From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 17:45:31 +0200
Subject: [RESEND PATCH 0/5] gcov fixes and maybe-uninitialized warnings
In-Reply-To: <20160510151437.GA12889@pobox.suse.cz>
References: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
 <20160510151437.GA12889@pobox.suse.cz>
Message-ID: <5021654.fHHR0eRNyc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 17:14:37 Michal Marek wrote:
> On Mon, Apr 25, 2016 at 05:35:26PM +0200, Arnd Bergmann wrote:
> > Hi Michal,
> > 
> > This is a resend of a series I originally sent back in February, but
> > unfortunately I never heard back from you. Could you apply these
> > patches for v4.7?
> > 
> > [PATCH 1/5] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
> > [PATCH 2/5] Kbuild: disable 'maybe-uninitialized' warning for
> > [PATCH 3/5] gcov: disable for COMPILE_TEST
> > [PATCH 4/5] gcov: disable tree-loop-im to reduce stack usage
> > [PATCH 5/5] gcov: disable -Wmaybe-uninitialized warning
> 
> Applied now, sorry for the delay.

Great, thanks!

	Arnd
