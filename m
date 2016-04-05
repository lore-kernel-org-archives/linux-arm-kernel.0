From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 5 Apr 2016 16:33:17 -0500
Subject: [PATCH 0/4] bam dma fixes and one dt extension
In-Reply-To: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20160405213317.GB3873@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:14:55AM +0200, Stanimir Varbanov wrote:
> Here are three bam dma fixes, which I made during testing qcrypto
> driver. The first one is a real fix, the second one is related to
> peripherals on which the BAM IP is initialized by remote execution
> environment, and the third one is a sleeping bug IMO.
> 
> The last patch is a extension again for peripherals which BAM is
> remotely controlled by other execution environment.
> 
> All patches has been tested on db410c board with apq8016.
> 

Stan,

Can you resend these patches w/ updates?  Or at least the remote control patch
if you can get that out faster.  And also include the dmaengine list.

Regards,

Andy
