From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 09 Aug 2012 09:15:13 -0600
Subject: [PATCH V3] ARM: dt: tegra: ventana: add regulators
In-Reply-To: <5023A716.50807@nvidia.com>
References: <1344017356-29352-1-git-send-email-swarren@wwwdotorg.org>
 <5023A716.50807@nvidia.com>
Message-ID: <5023D401.20303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2012 06:03 AM, Laxman Dewangan wrote:
> On Friday 03 August 2012 11:39 PM, Stephen Warren wrote:
>> From: Stephen Warren<swarren@nvidia.com>
>>
>> Ventana uses a TPS6586x regulator. Instantiate this, and hook up a
>> couple of fixed GPIO-controlled regulators too.
>>
>> The data was chosen to match the PMIC HW defaults, with the following
>> exception:
>>
>> ldo6: The HW default is 2.85v. The schematics are unlabelled. Internal
>> research indicates that 1.8v is correct. Our downstream kernel also uses
>> 1.8v.
>>
>> Portions based on work by Laxman Dewangan<ldewangan@nvidia.com>
...
> 
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> You can addd my ACK for harmony dts file.

There is no Harmony patch; just Paz00, Ventana, Seaboard. I assume you
meant to ack Seaboard as well, not Harmony?
