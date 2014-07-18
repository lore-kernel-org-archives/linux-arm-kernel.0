From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 18 Jul 2014 12:28:54 +0200
Subject: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <53C8C9BD.3070709@nvidia.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
 <53C8C9BD.3070709@nvidia.com>
Message-ID: <53C8F6E6.6020901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/18/2014 09:16 AM, Mikko Perttunen wrote:
> So here's v5: this time, as suggested, I handle the sata clock myself and let ahci_platform handle it too, leading it to be prepared+enabled twice. This works fine, and allows us to remove the DT ordering requirement.
> 
> I also have in the works a patchset that adds the name-based ahci_platform_get_resources function, but that is not quite ready yet, even if it is quite far along. Also, I am going on vacation and returning on 28.7., so if this v5 is acceptable maybe it could be merged for 3.17 and I could work on the new get_resources scheme after I get back from vacation?

Yes that works for me v3 of all the patches with no newer version +
v5 of patch 1 and 7 are pretty clean and can go into 3.17 from my pov,
Tejun can you pick these up for 3.17 please?

And thanks for working on a name-based ahci_platform_get_resources function
since what we've now in v5 is quite clean already I think it will be good
to take our time to get this right, so postponing this to 3.18 is fine
with me.

Regards,

Hans
