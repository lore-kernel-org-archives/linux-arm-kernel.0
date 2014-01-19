From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:56:09 +0100
Subject: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv ptr to
 ahci_platform_data init method
In-Reply-To: <20140119191706.GC32165@mtj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
 <20140119113051.GD11123@htj.dyndns.org> <52DC1EC4.3090807@redhat.com>
 <20140119191706.GC32165@mtj.dyndns.org>
Message-ID: <52DC2DD9.7070403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 08:17 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 07:51:48PM +0100, Hans de Goede wrote:
>> Yes, but they are part of arch/arm/mach-foo, so moving them is non trivial, and
>> I don't want to go make these kinda changes without hardware to test. Please keep
>> in mind that I'm partially cleaning up other peoples mess here (the imx bits
>> specifically). I'm willing to do that to some extend (*). But buying an imx6q board
>> and fixing that is about as far as I'm willing to go.
>
> If they can't be moved, the right thing to do is moving the header out
> to include/linux so that they can be included from those directories.
> Let's please not contort the API to fit the organizational issues.

Ok, asking the obvious here I guess, but you would accept a patch moving drivers/ata/ahci.h
to include/linux as part of this patch-set ?

Regards,

Hans
