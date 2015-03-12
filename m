From: vinceh@nvidia.com (Vince Hsu)
Date: Thu, 12 Mar 2015 20:23:18 +0800
Subject: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from
 driver
In-Reply-To: <20150312121912.GJ25944@htj.duckdns.org>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
 <20150312121912.GJ25944@htj.duckdns.org>
Message-ID: <55018536.2050904@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'd Hans.

Thanks,
Vince

On 03/12/2015 08:19 PM, Tejun Heo wrote:
> On Thu, Mar 12, 2015 at 08:15:15PM +0800, Vince Hsu wrote:
>> We have the generic PM domain support for Tegra SoCs now. So remove the
>> duplicated sequence here.
>>
>> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> Can you please repost this patch w/ Hans de Goede
> <hdegoede@redhat.com> cc'd?  Just reposting the patch as a reply to
> itself w/ the cc added should do.
>
> Thanks.
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0014-ata-ahci_tegra-remove-power-sequence-from-driver.patch
Type: text/x-patch
Size: 1619 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/c34387fc/attachment.bin>
