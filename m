From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 03 Aug 2012 12:49:12 -0600
Subject: [PATCH] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <501C1944.4030505@nvidia.com>
References: <1343932593-999-1-git-send-email-swarren@wwwdotorg.org>
 <501C1944.4030505@nvidia.com>
Message-ID: <501C1D28.60804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 12:32 PM, Laxman Dewangan wrote:
> On Friday 03 August 2012 12:06 AM, Stephen Warren wrote:
>> From: Stephen Warren<swarren@nvidia.com>
>>
>> The Toshiba AC100/PAZ00 uses a TPS6586x regulator. Instantiate this.
...
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

Thanks.

>> +    regulators {
>> +        compatible = "simple-bus";
>> +        #address-cells =<1>;
>> +        #size-cells =<0>;
>> +
> 
> Is "simple-bus" accepted?
> Accordingly I need to update for the Cardhu  also to have regulator
> support which I am going to send.

I believe so yes; the ability to use that bus type was the specific
purpose of:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-August/017963.html

... which Rob seems to find acceptable.
