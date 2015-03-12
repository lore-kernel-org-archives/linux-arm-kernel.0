From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 12 Mar 2015 13:33:29 +0100
Subject: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from
 driver
In-Reply-To: <55018536.2050904@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
 <20150312121912.GJ25944@htj.duckdns.org> <55018536.2050904@nvidia.com>
Message-ID: <55018799.3000705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12-03-15 13:23, Vince Hsu wrote:
> Cc'd Hans.
>
> Thanks,
> Vince
>
> On 03/12/2015 08:19 PM, Tejun Heo wrote:
>> On Thu, Mar 12, 2015 at 08:15:15PM +0800, Vince Hsu wrote:
>>> We have the generic PM domain support for Tegra SoCs now. So remove the
>>> duplicated sequence here.
>>>
>>> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
>> Can you please repost this patch w/ Hans de Goede
>> <hdegoede@redhat.com> cc'd?  Just reposting the patch as a reply to
>> itself w/ the cc added should do.
>>
>> Thanks.
>>

Patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
