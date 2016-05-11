From: petr@barix.com (Petr Kulhavy)
Date: Wed, 11 May 2016 17:10:40 +0200
Subject: [PATCH v5 2/4] ASoC: Davinci: McBSP: add device tree support for
 McBSP
In-Reply-To: <20160511145717.GJ6261@sirena.org.uk>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
 <1462804522-29544-3-git-send-email-petr@barix.com>
 <20160511145717.GJ6261@sirena.org.uk>
Message-ID: <57334B70.8000008@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.05.2016 16:57, Mark Brown wrote:
> On Mon, May 09, 2016 at 04:35:20PM +0200, Petr Kulhavy wrote:
>> This adds DT support for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx McBSP driver.
>>
>> Signed-off-by: Petr Kulhavy <petr@barix.com>
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> How did this manage to get review but not the accompanying binding?
The whole set got reviewed by Peter in version 4 and the binding in v4 
got acked by Rob.
For the patches 2 and 3 which were taken over into version 5 without any 
modification I left the Reviewed-by tag there.
But since I made a (minor) modification in the binding example I removed 
Rob's ack.

Petr
