From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Sep 2014 10:43:00 +0200
Subject: [PATCH 08/11 v5] coresight: adding documentation for coresight
In-Reply-To: <1409159852-7249-9-git-send-email-mathieu.poirier@linaro.org>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-9-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdbD3Ds=iPxwD57ERd=xPAyVvdVbMEfjqdtAvO-0YqT_EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 7:17 PM,  <mathieu.poirier@linaro.org> wrote:

> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Documentation for the coresight framework and drivers.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
(...)
>  Documentation/trace/coresight.txt | 237 ++++++++++++++++++++++++++++++++++++++

I guess you agreed on this location? If it's ARM-specific,
Documentation/arm/coresight.txt
is an alternative.

> +The file cstrace.bin can be decompressed using "ptm2human", DS-5 or Trace32.

Is ptm2human a candidate for the kernel tools/ directory?

Maybe not now but later?

+root at linaro-developer:/sys/kernel/debug/coresight# ls

Maybe reduce noise here:

root:/sys/kernel/debug/coresight# ls

The reader probably does not need to know the name of your
development system.

Yours,
Linus Walleij
