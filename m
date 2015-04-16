From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Apr 2015 11:40:08 +0100
Subject: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
In-Reply-To: <BN3PR0301MB121987D3E12F25B79E8C51EFEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
 <BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <DM2PR0301MB06402A7F6BF42B9A84669D94E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <BN3PR0301MB121987D3E12F25B79E8C51EFEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
Message-ID: <20150416104008.GB25640@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Varun,

Thanks for adding me to Cc.

On Wed, Apr 15, 2015 at 02:18:13PM +0100, Varun Sethi wrote:
> Yes, deviceid=stream id (i.e. ICID + other bits). I am not sure if TBU ID
> would also be forwarded as a part of stream id to GIC. My understanding is
> that TBU ID is forwarded (as a part of the stream ID) to the TCU in case
> of a TBU translation miss. In case of the LS2085 PCIe controller you would
> have to setup the PCIe device ID to stream ID translation table. We may
> have to restrict the number of entries based on the available number of
> contexts.

Unfortunately, I'm having a really hard time parsing this thread (some parts
of it simply don't make sense; others use non-architectural terms and
overall I don't get a feeling for the problem).

Please could you explain your system design step by step so that I can
understand (a) what you've built and (b) why the current design of Linux is
causing you problems?

Sorry if I'm just being thick, but it's important that we get this right.

Cheers,

Will
