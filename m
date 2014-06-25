From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Tue, 24 Jun 2014 19:19:26 -0500
Subject: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <20140624122639.GL10202@titan.lakedaemon.net>
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140624122639.GL10202@titan.lakedaemon.net>
Message-ID: <53AA158E.1040700@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2014 7:26 AM, Jason Cooper wrote:
> On Mon, Jun 23, 2014 at 07:32:58PM -0500, suravee.suthikulpanit at amd.com wrote:
>> This patch set introduces support for MSI(-X) in GICv2m specification,
>> which is implemented in some variation of GIC400.
>>
>> This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
>> (https://lkml.org/lkml/2014/3/14/320).
>
> Is this a build, boot, or runtime dependency?
>
> thx,
>
> Jason.
>

For all of the above.

Suravee
