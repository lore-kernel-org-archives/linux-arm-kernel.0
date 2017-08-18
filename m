From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 18 Aug 2017 10:26:54 +0530
Subject: [PATCH v2 03/16] dmaengine: bcm-sba-raid: Common flags for
 sba_request state and fence
In-Reply-To: <20170817034534.GY3053@localhost>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-4-git-send-email-anup.patel@broadcom.com>
 <20170817034534.GY3053@localhost>
Message-ID: <CAALAos8HhiGO3XHDS3ia5G51TmYWGeY9aSzCBDoWKSqr195Meg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 9:15 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Aug 01, 2017 at 04:07:47PM +0530, Anup Patel wrote:
>> This patch merges sba_request state and fence into common
>> sba_request flags. Also, in-future we can extend sba_request
>> flags as required.
>
> and it also changes the flag values to bits, which I have no idea why that
> was done, care to explain that please...

I thought its better to have separate bit each sba_request state so
that when a sba_request is accidentally in two states then we can
debug better.

I will restore state values.

Regards,
Anup
