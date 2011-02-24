From: mmarek@suse.cz (Michal Marek)
Date: Thu, 24 Feb 2011 16:26:34 +0100
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110216200734.GA25184@merkur.ravnborg.org>
	<1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4D6678AA.9000503@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.2.2011 21:47, Uwe Kleine-K?nig wrote:
> This was disabled in commit
> 
> 	e5f95c8 (kbuild: print only total number of section mismatces found)
> 
> because there were too many warnings.  Now we're down to a reasonable
> number again, so we start scaring people with the details.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

OK, applied to kbuild-2.6.git#kbuild.

Thanks,
Michal
