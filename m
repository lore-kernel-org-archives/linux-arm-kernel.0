From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 18 Aug 2017 11:35:51 +0530
Subject: [PATCH v2 03/16] dmaengine: bcm-sba-raid: Common flags for
 sba_request state and fence
In-Reply-To: <20170818052501.GD3053@localhost>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-4-git-send-email-anup.patel@broadcom.com>
 <20170817034534.GY3053@localhost>
 <CAALAos8HhiGO3XHDS3ia5G51TmYWGeY9aSzCBDoWKSqr195Meg@mail.gmail.com>
 <20170818052501.GD3053@localhost>
Message-ID: <CAALAos-UJ4QLbtyE0XzPR=HepDH1m4YnLQG=nTwaL47991F7vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 10:55 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Aug 18, 2017 at 10:26:54AM +0530, Anup Patel wrote:
>> On Thu, Aug 17, 2017 at 9:15 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Tue, Aug 01, 2017 at 04:07:47PM +0530, Anup Patel wrote:
>> >> This patch merges sba_request state and fence into common
>> >> sba_request flags. Also, in-future we can extend sba_request
>> >> flags as required.
>> >
>> > and it also changes the flag values to bits, which I have no idea why that
>> > was done, care to explain that please...
>>
>> I thought its better to have separate bit each sba_request state so
>> that when a sba_request is accidentally in two states then we can
>> debug better.
>
> that is fine, but you need to comminucate the motivation behind such a
> change!!

Okay, I will add this info to commit description.

>
>>
>> I will restore state values.
>
> either ways am okay, but if we are not using bits smartly then why to change

Okay, I will keep new state values as-is and only update commit
description.

Regards,
Anup
