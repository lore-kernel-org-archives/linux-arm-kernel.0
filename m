From: davidb@codeaurora.org (David Brown)
Date: Wed, 6 Jun 2012 13:28:33 -0700
Subject: Supporting non-device tree consumers with device tree regulator
 drivers
In-Reply-To: <4FCEE5DA.7090403@ti.com>
References: <4FCE30D6.7060102@codeaurora.org>
 <4FCEE5DA.7090403@ti.com>
Message-ID: <20120606202833.GA11202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 10:38:42AM +0530, Rajendra Nayak wrote:
> On Tuesday 05 June 2012 09:46 PM, David Collins wrote:
> >In the long term, this problem should go away of its own accord.  However,
> >in the short term, many systems are converting over to using device tree.
> >  Therefore, we are left with a situation currently where some regulator
> >consumer drivers are being probed via device tree and some are being
> >probed via board file devices within a single platform.
> 
> Is this a situation you are facing in your mainline kernel or internal
> trees? What you explain would need you to work with hybrid board files
> with some devices created through device tree and some others statically
> from the board file in the kernel, and that approach was already shot
> down as unacceptable.

As I understand, this is something being done on our internal kernel.
I don't think this really applies to the mainline kernel, since none
of these transitionary drivers are going into the upstream kernel
without being made to work with device tree.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
