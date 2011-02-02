From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Feb 2011 16:20:48 +0000
Subject: [PATCH v1 0/9] pruss mfd drivers
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302487783A6@dbde02.ent.ti.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302487783A6@dbde02.ent.ti.com>
Message-ID: <20110202162048.GF9810@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 09:43:51PM +0530, Nori, Sekhar wrote:

> To automate copying the right folks on each patch, please use:

> git-send-email --to <davinci list> --cc-cmd=scripts/get_maintainer.pl  [...]

Please don't use get_maintainer.pl directly like this - you need to
apply some thought and consideration to the results as it generates both
false positives and false negatives.
