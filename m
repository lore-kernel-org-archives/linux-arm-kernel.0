From: rabin@rab.in (Rabin Vincent)
Date: Mon, 3 Feb 2014 21:37:56 +0100
Subject: [PATCH v5 15/16] ARM: add uprobes support
In-Reply-To: <1391445367.3509.30.camel@linaro1.home>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
 <1390507559-4697-16-git-send-email-dave.long@linaro.org>
 <1391445367.3509.30.camel@linaro1.home>
Message-ID: <CAH+eYFAW=6+bzS7fiPM6G+b3GA6HMf7pOVxEusFSGHmGmZG1RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-03 Jon Medhurst (Tixy) <tixy@linaro.org>:
> On Thu, 2014-01-23 at 15:05 -0500, David Long wrote:
> > From: "David A. Long" <dave.long@linaro.org>
> >
> > Using Rabin Vincent's ARM uprobes patches as a base, enable uprobes
> > support on ARM.
> >
> > Caveats:
> >
> >  - Thumb is not supported
> >
> > Signed-off-by: David A. Long <dave.long@linaro.org>
>
> As this is based on Rabin's work, and the new files have his Copyright,
> then this patch also needs his 'Signed-off-by'. Rabin, I assume that you
> agree?

Don't know if it's needed, but if it is, you may certainly add it to
this patch, David:

  Signed-off-by: Rabin Vincent <rabin@rab.in>
