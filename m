From: nm@ti.com (Nishanth Menon)
Date: Fri, 19 Aug 2016 18:03:14 -0500
Subject: [PATCH] ARM: dts: keystone-k2g: Add Message Manager node
In-Reply-To: <e39f772a-8a30-4c69-fdd9-8b8a639207a6@oracle.com>
References: <20160819204748.21529-1-nm@ti.com>
 <e39f772a-8a30-4c69-fdd9-8b8a639207a6@oracle.com>
Message-ID: <CAGo_u6opv1nGTXeP0RKQVFDUNmQbRDTXsucDjyoN9bSbG1SGoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Fri, Aug 19, 2016 at 3:55 PM, Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
>>
> Patch looks good Nishant. Do you want to send a patch to update
> the config to enable TI_MESSAGE_MANAGER and MAILBOX ? Are we missing
> anything upstream yet to enable these ?

for message manager, nothing other than the dts(this patch) and
defconfig changes. I just finished putting the stack together and
re-testing things and they work good. will send the defconfig in a few
mins.

---
Regards,
Nishanth Menon
