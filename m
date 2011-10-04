From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 5 Oct 2011 00:30:43 +0200
Subject: [PATCH] PM: HIBERNATION: add resume_wait param to support
	MMC-like devices as resume file
In-Reply-To: <CAGsJ_4znTLmjd_qhgru_aOZPMEZc=dyXEQTqdsVGKr-GaryQsQ@mail.gmail.com>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
	<59872.1317299401@turing-police.cc.vt.edu>
	<CAGsJ_4znTLmjd_qhgru_aOZPMEZc=dyXEQTqdsVGKr-GaryQsQ@mail.gmail.com>
Message-ID: <201110050030.43953.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 29, 2011, Barry Song wrote:
> hi Valdis,
> 
> 2011/9/29  <Valdis.Kletnieks@vt.edu>:
> > On Thu, 29 Sep 2011 02:29:08 PDT, Barry Song said:
> >
> >> This patch adds resumewait kernel param just like rootwait so
> >> that we have enough time to wait mmc ready. The differene is
> >> here we wait for resume partition but rootwait waits for rootfs
> >> partition.
> >
> > OK, seems a reasonable idea...
> >
> >> kernel/power/hibernate.c |   16 ++++++++++++++++
> >> 1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > We have a __setup() parameter, this patch appears to be missing
> > a hunk for Documentation/kernel-parameters.txt?
> >
> > Fix that issue, and you can stick this on there:
> >
> > Reviewed-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> thanks. i'll add the document in v2.

I can't find the v2.  Have you posted it already?

Rafael
