From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 Jan 2014 11:50:35 -0700
Subject: [PATCH v2 3/6] ARM: tegra: Add efuse bindings
In-Reply-To: <20140108133951.GD1592@ulmo.nvidia.com>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-4-git-send-email-pdeschrijver@nvidia.com>
 <52CB14D3.2060904@wwwdotorg.org> <20140108133951.GD1592@ulmo.nvidia.com>
Message-ID: <52CD9DFB.9010007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2014 06:39 AM, Thierry Reding wrote:
> On Mon, Jan 06, 2014 at 01:40:51PM -0700, Stephen Warren wrote:
>> On 12/24/2013 06:32 AM, Peter De Schrijver wrote:
> [...]
>>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>>
>>> +	efuse at 7000F800 {
>>
>> "fuse" might be a better node name; "efuse" is presumably the name of
>> the instance, not the type of object.
> 
> There's another occurrence I noticed recently where we haven't followed
> that rule. The PMIC node on Venice2 for instance is called as3722.
> Perhaps that should also be renamed.

Yes, we should fix that. Care to send a patch?
