From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 18:36:50 +0000
Subject: [PATCH V13 08/10] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <56B247A1.20503@codeaurora.org>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-9-git-send-email-okaya@codeaurora.org>
 <20160201153542.GA20396@leverpostej>
 <56B247A1.20503@codeaurora.org>
Message-ID: <20160203183650.GI1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 01:32:01PM -0500, Sinan Kaya wrote:
> Hi Mark,
> 
> On 2/1/2016 10:35 AM, Mark Rutland wrote:
> >> Removing the flexibility to choose the event channel as there is no real
> >> > use case right now. We have been using the values in ACPI that match the HW
> >> > defaults. OS is reading the event-channel from the HW register now.
> > Fold this in to the patches adding the binding and the driver.
> > 
> > There is no reason to add this then remove it within the same series.
> > 
> > Mark.
> > 
> 
> Before I post the next rev, I'd like to see if I missed something in the series when 
> it comes to your comments. 
> 
> Can you please take a look and let me know?

Sorry, but it's going to be far easier to review with useless code
removed, so I will wait until the next posting where this patch is
folded in.

Thanks,
Mark.
