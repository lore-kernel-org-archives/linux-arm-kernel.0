From: dhdang@apm.com (Duc Dang)
Date: Fri, 18 Sep 2015 10:22:24 -0700
Subject: [PATCH 1/1] PCI/MSI: X-Gene: Remove msi_controller assignment in
 X-Gene PCIe driver
In-Reply-To: <20150918095956.2e27c93c@arm.com>
References: <1442449900-30842-1-git-send-email-dhdang@apm.com>
 <20150918095956.2e27c93c@arm.com>
Message-ID: <CADaLND=-YW_Y=tmwJWUQqqbD2_UL7KHQh-fK-9BkBp-43SqXvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 1:59 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Wed, 16 Sep 2015 17:31:40 -0700
> Duc Dang <dhdang@apm.com> wrote:
>
>> With commit 8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of
>> struct msi_controller"), it is no longer required to assign
>> msi_controller for X-Gene PCIe host bridge to support MSI. This
>> patch removes this unnecessary code and also helps avoid a warning
>> message ("failed to enable MSI") during boot.
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> Cc: Tanmay Inamdar <tinamdar@apm.com>
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, Marc.

>
>         M.
> --
> Jazz is not dead. It just smells funny.



-- 
Regards,
Duc Dang.
