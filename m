From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 10 Sep 2015 17:30:17 +0100
Subject: [PATCH v4 3/4] irqchip: GIC: Convert to EOImode == 1
In-Reply-To: <55F1B011.6090204@arm.com>
References: <1440604845-28229-1-git-send-email-marc.zyngier@arm.com>
 <1440604845-28229-4-git-send-email-marc.zyngier@arm.com>
 <55F08731.3050402@citrix.com> <55F15353.2000800@arm.com>
 <55F1AE75.6000405@citrix.com> <55F1B011.6090204@arm.com>
Message-ID: <55F1B019.6050800@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/15 17:30, Marc Zyngier wrote:
> On 10/09/15 17:23, Julien Grall wrote:
>> On 10/09/15 10:54, Marc Zyngier wrote:
> 
> [...]
> 
>>> In the meantime, can you give the following patch a shot? My Mustang is 
>>> wired to a 4kB CPU interface, so I'll need your help to test it.
>>
>> I applied the two patches on top of linus/master and I'm able to boot
>> correctly on X-gene. Thank you!
> 
> Thanks for testing. Can I put your Tested-by tag on the patch when I
> send it to Thomas?

Sure:

Tested-by: Julien Grall <julien.grall@citrix.com>

Regards,

-- 
Julien Grall
