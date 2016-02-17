From: tchalamarla@caviumnetworks.com (Tirumalesh Chalamarla)
Date: Wed, 17 Feb 2016 13:46:47 -0800
Subject: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <20160217200029.GB4751@mtj.duckdns.org>
References: <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
 <20160216144250.GD31343@rric.localdomain>
 <56C37524.5090000@caviumnetworks.com> <56C37AD3.4030407@caviumnetworks.com>
 <56C37D94.8080403@caviumnetworks.com>
 <20160216211410.GI25086@rric.localdomain>
 <56C3AD1C.2000003@caviumnetworks.com> <20160217112931.GB31970@arm.com>
 <56C4C2AE.90009@caviumnetworks.com> <20160217200029.GB4751@mtj.duckdns.org>
Message-ID: <56C4EA47.6010908@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/17/2016 12:00 PM, Tejun Heo wrote:
> Hello, David.
>
> On Wed, Feb 17, 2016 at 10:57:50AM -0800, David Daney wrote:
>> If the ahci/ata maintainers insist, we can add that.
>
> I don't mind whether it is CONFIG_ARM64 or something more specific but
> I think it's a good idea to gate it some way.
>
Already posted a V3, could you please comment on that.

Thanks,
Tirumalesh.

>> <sarcasm>
>
> If at all possible, please write plain arguments.
>
>> Should we also add some CONFIG_ variables for:
>>
>>    ahci_mcp89_apple_enable()
>>    ahci_sb600_enable_64bit()
>>    ahci_p5wdh_workaround()
>
> And I think these should be gated behind CONFIG_X86.  The lack of
> gating is historic, not intentional.
>
> Thanks.
>
