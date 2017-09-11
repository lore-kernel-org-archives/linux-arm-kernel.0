From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 11 Sep 2017 14:23:48 +0100
Subject: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
In-Reply-To: <mvmefrdbesb.fsf@suse.de>
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org>
 <mvmzia1bnvu.fsf@suse.de>
 <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net>
 <mvmingpbh1j.fsf@suse.de>
 <CAGCh1+=eqF_pgLmVYPLA1peudTUO6jvn4yVzL349J4n9=uVt6Q@mail.gmail.com>
 <mvmefrdbesb.fsf@suse.de>
Message-ID: <20170911132348.mgfc3zmncd2sgfbk@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 02:28:20PM +0200, Andreas Schwab wrote:
> On Sep 11 2017, Graeme Gregory <graeme.gregory@linaro.org> wrote:
> 
> > Considering the SPCR table in question seems mildly insane, you could
> > always unload the SPCR in grub.
> 
> How do you "unload the SPCR"?  But in any case, console= should always
> take precedence.

I am not saying it shouldn't. But you should probably talk to your
supplier with regards to fixing their system.

The BMC knows which console you are attached to, and the firmware
still instructs the kernel to use something else.

/
    Leif
