From: mmarek@suse.cz (Michal Marek)
Date: Tue, 10 May 2016 17:14:37 +0200
Subject: [RESEND PATCH 0/5] gcov fixes and maybe-uninitialized warnings
In-Reply-To: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
References: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
Message-ID: <20160510151437.GA12889@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 05:35:26PM +0200, Arnd Bergmann wrote:
> Hi Michal,
> 
> This is a resend of a series I originally sent back in February, but
> unfortunately I never heard back from you. Could you apply these
> patches for v4.7?
> 
> [PATCH 1/5] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
> [PATCH 2/5] Kbuild: disable 'maybe-uninitialized' warning for
> [PATCH 3/5] gcov: disable for COMPILE_TEST
> [PATCH 4/5] gcov: disable tree-loop-im to reduce stack usage
> [PATCH 5/5] gcov: disable -Wmaybe-uninitialized warning

Applied now, sorry for the delay.

Michal
