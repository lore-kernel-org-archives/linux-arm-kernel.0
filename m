From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 18 Sep 2013 22:08:54 +0530
Subject: [PATCH REPOST] ARM: tegra: use dt-binding header for key code
In-Reply-To: <5239C6AC.10403@nvidia.com>
References: <1379510552-23401-1-git-send-email-ldewangan@nvidia.com>
 <5239C6AC.10403@nvidia.com>
Message-ID: <5239D71E.3040005@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 September 2013 08:58 PM, Stephen Warren wrote:
> On 09/18/2013 07:22 AM, Laxman Dewangan wrote:
>> In place of hardcoding the key code in DTS file and comment the
>> key code as side notes, use the key code macro defines in the
>> dt-bindings/input/input.h directly.
> I can apply this, but aren't there many other Tegra DT files that need
> conversion too?
Yes, I am planning to this in next few days. I will post different 
patches for different boards.
If it is fine to you, it can be applied this patch.
