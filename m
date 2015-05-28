From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 May 2015 12:58:23 +0100
Subject: [PATCH v4 01/18] mfd: add new driver for Sharp LoCoMo
In-Reply-To: <CALT56yO5Eu4Bk+_4sn2WgURh9YTsym9inWkvJftKUi_aLy5XXw@mail.gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
 <1432554113-26280-2-git-send-email-dbaryshkov@gmail.com>
 <20150527102756.GH11677@x1>
 <CALT56yO5Eu4Bk+_4sn2WgURh9YTsym9inWkvJftKUi_aLy5XXw@mail.gmail.com>
Message-ID: <20150528115823.GQ11677@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 May 2015, Dmitry Eremin-Solenikov wrote:

> 2015-05-27 13:27 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> > On Mon, 25 May 2015, Dmitry Eremin-Solenikov wrote:
> >
> >> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
> >> several design issues (special bus instead of platform bus, doesn't use
> >> mfd-core, etc).
> >>
> >> Implement 'core' parts of locomo support as an mfd driver.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >
> > These things are much easier to re-review if you keep a change-log
> > here.
> >
> >>  drivers/mfd/Kconfig        |  10 ++
> >>  drivers/mfd/Makefile       |   1 +
> >>  drivers/mfd/locomo.c       | 336 +++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/locomo.h | 169 +++++++++++++++++++++++
> >>  4 files changed, 516 insertions(+)
> >>  create mode 100644 drivers/mfd/locomo.c
> >>  create mode 100644 include/linux/mfd/locomo.h
> >
> > Looks good now though:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> > How do you plan for this to be merged?
> 
> I'd like for this to be merged either through mfd tree or through the
> arm-soc (or rmk's ARM) tree.
> Some of the respective maintainers already gave their blessing for
> this patchset to be merged
> not through their subsystem trees.

I can take it through MFD.  Once you have all the required Acks,
resubmit the set with them all applied with a note in the cover-letter
to that affect and I'll apply.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
