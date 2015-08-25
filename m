From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Aug 2015 11:35:46 +0100
Subject: [PATCH-v2 1/5] mfd: 88pm800: Fix tabbing issue
In-Reply-To: <55DC2C4D.1040304@linaro.org>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440442594-3102-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150825075246.GF19409@x1> <55DC2C4D.1040304@linaro.org>
Message-ID: <20150825103546.GQ19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:

> 
> 
> On Tuesday 25 August 2015 01:22 PM, Lee Jones wrote:
> >On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:
> >
> >>Driver had coding style issues where spaces were used instead
> >>of tabs. This patch fixes them all.
> >>
> >>Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> >>---
> >>  drivers/mfd/88pm800.c | 125 ++++++++++++++++++++++++--------------------------
> >>  1 file changed, 61 insertions(+), 64 deletions(-)
> >
> >Same comment as before.
> >
> >How similar is this file to the other one?
> 
> I believe you are referring to include/linux/mfd/88pm80x.h
> 
> >
> >Can you reduce the size by having shared register defines?
> >
> 
> Not sure whether I understand your comment here,
> They are common defines.

I guess the question was a little convoluted.

How about; why are the extra defines in the driver?  Why aren't all of
them in the header file?  What is the difference between the defines
in the C file compared with the ones defined in the header?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
