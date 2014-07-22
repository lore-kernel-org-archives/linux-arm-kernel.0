From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jul 2014 15:03:12 -0600
Subject: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <20140718150603.GA7196@ulmo>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
 <53C8C9BD.3070709@nvidia.com> <53C8F6E6.6020901@redhat.com>
 <20140718150603.GA7196@ulmo>
Message-ID: <53CED190.8060702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2014 09:06 AM, Thierry Reding wrote:
> On Fri, Jul 18, 2014 at 12:28:54PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 07/18/2014 09:16 AM, Mikko Perttunen wrote:
>>> So here's v5: this time, as suggested, I handle the sata clock myself and let ahci_platform handle it too, leading it to be prepared+enabled twice. This works fine, and allows us to remove the DT ordering requirement.
>>>
>>> I also have in the works a patchset that adds the name-based ahci_platform_get_resources function, but that is not quite ready yet, even if it is quite far along. Also, I am going on vacation and returning on 28.7., so if this v5 is acceptable maybe it could be merged for 3.17 and I could work on the new get_resources scheme after I get back from vacation?
>>
>> Yes that works for me v3 of all the patches with no newer version +
>> v5 of patch 1 and 7 are pretty clean and can go into 3.17 from my pov,
>> Tejun can you pick these up for 3.17 please?
> 
> Tejun,
> 
> I think the following patches can go through your tree without causing
> breakage through unresolved dependencies:
...
> Stephen, the rest of the patches would probably best go through the
> Tegra tree so that we can handle the dependencies there. I've already
> sent out pull requests for 3.17 today, but maybe Arnd and Olof can be
> convinced to take one more.

At this point, I'm just going to wait for 3.18 for anything that didn't
make it into 3.17.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140722/997fcbdb/attachment.sig>
