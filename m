From: schwab@suse.de (Andreas Schwab)
Date: Mon, 11 Sep 2017 13:39:36 +0200
Subject: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
In-Reply-To: <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net> (Leif
 Lindholm's message of "Mon, 11 Sep 2017 12:05:22 +0100")
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org>
 <mvmzia1bnvu.fsf@suse.de>
 <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net>
Message-ID: <mvmingpbh1j.fsf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 11 2017, Leif Lindholm <leif.lindholm@linaro.org> wrote:

> Are you asking because you want to use a different console in a lab
> setup or because there are issues with SPCR on your platform?

The console from the SPCR is not the one forwarded by the BMC.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
