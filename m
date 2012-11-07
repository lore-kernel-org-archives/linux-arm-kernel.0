From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 7 Nov 2012 11:30:07 +0530
Subject: [PATCH] Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints"
In-Reply-To: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
Message-ID: <CAM=Q2cuqQvdgCbH+_KS8FFbVsMDgkh9Kszq2ZLnzQYf6=H8B1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2012 at 10:01 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> This reverts commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc.
> This commit causes I2C timeouts to appear on several OMAP3430/3530-based
> boards:
>
>   http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
>   http://marc.info/?l=linux-arm-kernel&m=135067558415214&w=2
>   http://marc.info/?l=linux-arm-kernel&m=135216013608196&w=2
>
> and appears to have been sent for merging before one of its prerequisites
> was merged:
>
>   http://marc.info/?l=linux-arm-kernel&m=135219411617621&w=2
>

Not a comment however was curious does merging the dependency.
make the issue go away?
