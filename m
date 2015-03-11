From: schwab@suse.de (Andreas Schwab)
Date: Wed, 11 Mar 2015 13:43:21 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <550025E0.7030008@suse.de> (Alexander Graf's message of "Wed, 11
 Mar 2015 06:24:16 -0500")
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <20141204182049.GB7749@arm.com> <54833BAF.1030405@suse.de>
 <20141208101026.GD27367@arm.com> <550025E0.7030008@suse.de>
Message-ID: <mvmmw3jemc6.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Graf <agraf@suse.de> writes:

> Unfortunately however, the 32bit glibc has a bogus mmap() implementation
> that hard codes 4k page size.

Which is correct (it's not a page size).

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
