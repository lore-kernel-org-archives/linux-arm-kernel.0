From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 2 Feb 2011 22:06:47 +0530
Subject: [PATCH v1 0/9] pruss mfd drivers
In-Reply-To: <20110202162048.GF9810@sirena.org.uk>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302487783A6@dbde02.ent.ti.com>
	<20110202162048.GF9810@sirena.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302487783CA@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 21:50:48, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 09:43:51PM +0530, Nori, Sekhar wrote:
> 
> > To automate copying the right folks on each patch, please use:
> 
> > git-send-email --to <davinci list> --cc-cmd=scripts/get_maintainer.pl  [...]
> 
> Please don't use get_maintainer.pl directly like this - you need to
> apply some thought and consideration to the results as it generates both
> false positives and false negatives.

Point taken. I usually do a --dry-run before actually sending
just to verify the results.

Thanks,
Sekhar
