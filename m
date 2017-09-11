From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 11 Sep 2017 13:24:47 +0100
Subject: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
In-Reply-To: <mvmingpbh1j.fsf@suse.de>
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org> <mvmzia1bnvu.fsf@suse.de>
 <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net> <mvmingpbh1j.fsf@suse.de>
Message-ID: <CAGCh1+=eqF_pgLmVYPLA1peudTUO6jvn4yVzL349J4n9=uVt6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2017 at 12:39, Andreas Schwab <schwab@suse.de> wrote:
> On Sep 11 2017, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
>> Are you asking because you want to use a different console in a lab
>> setup or because there are issues with SPCR on your platform?
>
> The console from the SPCR is not the one forwarded by the BMC.
>
Considering the SPCR table in question seems mildly insane, you could
always unload the SPCR in grub.

Graeme
