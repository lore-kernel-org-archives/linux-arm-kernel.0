From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Aug 2016 13:44:15 +0530
Subject: [PATCH 10/10] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <497ddb6c-0233-657f-72c6-b844b798ff11@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-11-git-send-email-okaya@codeaurora.org>
 <20160724064256.GA9681@localhost>
 <e6560c8b-e18e-9e32-5b51-c1c12d8551ce@codeaurora.org>
 <20160804124641.GE9681@localhost>
 <497ddb6c-0233-657f-72c6-b844b798ff11@codeaurora.org>
Message-ID: <20160808081415.GV9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 09:59:43AM -0400, Sinan Kaya wrote:
> On 8/4/2016 8:46 AM, Vinod Koul wrote:
> >> > Yes, I do have a new device ID for platforms with MSI capability. 
> >> > 
> >> > Which new binding are you referring to?
> > If you have "QCOM8062" why do you need DT to tell hidma-1.1 ?
> 
> Unfortunately, DT cannot do a binding with the ACPI names. Similarly, ACPI
> cannot do a binding with the DT name. 
> 
> The structure of binding name is also subject to different kind of rules
> for DT and ACPI.
> 
> This driver supports both device tree and ACPI. That's why, two different
> names are required.

Hmmm, wasn't the who get_property stuff supposed to make properties work on
both ACPi & DT. I am not sure though about the current state of affairs on
that.

-- 
~Vinod
