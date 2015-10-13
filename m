From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 13 Oct 2015 11:53:44 +0100
Subject: [PATCH v2 5/9] dmaengine: st_fdma: Add xp70 firmware loading
 mechanism.
In-Reply-To: <20151007112201.GB4810@vkoul-mobl.iind.intel.com>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-6-git-send-email-peter.griffin@linaro.org>
 <20151007112201.GB4810@vkoul-mobl.iind.intel.com>
Message-ID: <20151013105344.GB30342@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, 07 Oct 2015, Vinod Koul wrote:

> On Fri, Sep 11, 2015 at 03:14:27PM +0100, Peter Griffin wrote:
> > This patch adds the code to load the xp70 fdma firmware
> > using the asynchronous request_firmware_nowait call
> > so as not to delay bootup of builtin code.
> 
> Okay we need to check here. Can the driver be built in,

Yes it can be built in.

> if so this is not
> the right usage. You should load the firmware on first open for this device
> 
> See https://lkml.org/lkml/2015/8/26/588

Ok, thanks for the link, I will see if it is possible to load the firmware after
the first open. If it is I will do this in the next version.

regards,

Peter.
