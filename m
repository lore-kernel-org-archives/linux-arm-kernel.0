From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 17 Aug 2016 14:43:22 -0500
Subject: [PATCH 0/2] Fix Qualcomm 8064/8660 interrupt flags
In-Reply-To: <CACRpkdZR-R7cZkfpMJLOt8ND1bQmdxCuVF1BWEgeagWwfXAEDQ@mail.gmail.com>
References: <1470386318-17694-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZR-R7cZkfpMJLOt8ND1bQmdxCuVF1BWEgeagWwfXAEDQ@mail.gmail.com>
Message-ID: <20160817194322.GB18215@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 10:56:22AM +0200, Linus Walleij wrote:
> On Fri, Aug 5, 2016 at 10:38 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This came out after some frustration with trying to flag a PM8058
> > interrupt line on the APQ8060 (MSM8660) to trigger on falling
> > edges. It was conflicting badly with predefined contradictory
> > flags in the device tree for the entire GPIO block. The same
> > seems to hold for the MPP GPIO IRQs.
> 
> Andy are you funneling these two patches for fixes?

I looked at these last night.  What's the outcome of John's issues with the
patch not fixing his problem?  Do these need to be taken irrespective of his
plight?

Andy
