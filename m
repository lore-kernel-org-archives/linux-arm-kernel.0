From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 09:28:08 -0600
Subject: [PATCH] ARM: tegra: Add charger subnode to tps65090 node
In-Reply-To: <519A4027.2020801@nvidia.com>
References: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
 <5196C3F2.8070204@wwwdotorg.org> <519A4027.2020801@nvidia.com>
Message-ID: <519A4108.2040606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 09:24 AM, Rhyland Klein wrote:
> On 5/17/2013 7:57 PM, Stephen Warren wrote:
>> On 04/10/2013 01:51 PM, Rhyland Klein wrote:
>>> The charger is now represented by a distinct subnode of the tps65090
>>> device. Add this node and enable low current charging with it.
>>
>> What's the status of the TPS60590 bindings; are they agreed upon by
>> NVIDIA, TI, and SlimLogic yet? In other words, is this patch still
>> something I should apply for 3.11, or does it need to be reworked?
> 
> I haven't seen any discussion with slimlogic or TI about the tps65090.
> As far as I know the bindings for this driver haven't changed.
> 
> Laxman, do you think the work on the palmas driver will impact the
> design of the bindings for the tps65090?

Sorry, perhaps I'm confusing two different chips. If TPS65090 isn't
Palmas, then ignore my question. In which case, I suppose I should just
apply your patch then?
