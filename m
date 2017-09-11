From: schwab@suse.de (Andreas Schwab)
Date: Mon, 11 Sep 2017 14:28:20 +0200
Subject: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
In-Reply-To: <CAGCh1+=eqF_pgLmVYPLA1peudTUO6jvn4yVzL349J4n9=uVt6Q@mail.gmail.com>
 (Graeme Gregory's message of "Mon, 11 Sep 2017 13:24:47 +0100")
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org>
 <mvmzia1bnvu.fsf@suse.de>
 <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net>
 <mvmingpbh1j.fsf@suse.de>
 <CAGCh1+=eqF_pgLmVYPLA1peudTUO6jvn4yVzL349J4n9=uVt6Q@mail.gmail.com>
Message-ID: <mvmefrdbesb.fsf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 11 2017, Graeme Gregory <graeme.gregory@linaro.org> wrote:

> Considering the SPCR table in question seems mildly insane, you could
> always unload the SPCR in grub.

How do you "unload the SPCR"?  But in any case, console= should always
take precedence.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
