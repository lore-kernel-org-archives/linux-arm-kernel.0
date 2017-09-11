From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 11 Sep 2017 14:03:10 +0100
Subject: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
In-Reply-To: <mvmefrdbesb.fsf@suse.de>
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org> <mvmzia1bnvu.fsf@suse.de>
 <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net> <mvmingpbh1j.fsf@suse.de>
 <CAGCh1+=eqF_pgLmVYPLA1peudTUO6jvn4yVzL349J4n9=uVt6Q@mail.gmail.com>
 <mvmefrdbesb.fsf@suse.de>
Message-ID: <CAGCh1+=AKuD6yBdJSx=cGwrReZ8KMDd2SuSXKAqtpCLcPHfOmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2017 at 13:28, Andreas Schwab <schwab@suse.de> wrote:
> On Sep 11 2017, Graeme Gregory <graeme.gregory@linaro.org> wrote:
>
>> Considering the SPCR table in question seems mildly insane, you could
>> always unload the SPCR in grub.
>
> How do you "unload the SPCR"?  But in any case, console= should always
> take precedence.
>
Ah apologies, I thought the acpi command in grub could delete a table,
but it seems it cannot.

Graeme
