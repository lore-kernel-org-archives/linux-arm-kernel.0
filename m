From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jan 2013 10:20:10 +0000
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
In-Reply-To: <20130122100607.GH23505@n2100.arm.linux.org.uk>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20130122090000.GH6857@gmail.com>
 <CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
 <20130122100607.GH23505@n2100.arm.linux.org.uk>
Message-ID: <20130122102010.GL6857@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013, Russell King - ARM Linux wrote:

> On Tue, Jan 22, 2013 at 10:53:42AM +0100, Linus Walleij wrote:
> > On Tue, Jan 22, 2013 at 10:00 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > >> From: Lee Jones <lee.jones@linaro.org>
> > >>
> > >> There are currently two instances of the ios_handler being used.
> > >> Both of which mearly toy with some regulator settings. Now there
> > >> is a GPIO regulator API, we can use that instead, and lessen the
> > >> per platform burden. By doing this, we also become more Device
> > >> Tree compatible.
> > >
> > > Russell,
> > >
> > > Why is this patch in your tree with Ulf as the Author?
> > 
> > This is because of the way Russell's patch tracker works, it sets
> > Author: to the name of the person using the patch tracker and
> > discards the From: field in the beginning of the patch which
> > git am will conversely respect.
> 
> Actually, the reverse.  It does now respect the From: line, but the
> From: line will be ignored for all notifications about the patch
> because the patch system was never built to parse the actual comments
> when sending out the email notifications.

So what do I have to do to reaffirm myself as the author?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
