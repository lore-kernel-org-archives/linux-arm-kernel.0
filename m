From: nm@ti.com (Nishanth Menon)
Date: Mon, 05 Jan 2015 06:47:39 -0600
Subject: [PATCH V3] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
In-Reply-To: <20150103233949.GA4108@earth.universe>
References: <1420309826-7904-1-git-send-email-nm@ti.com>
 <20150103233949.GA4108@earth.universe>
Message-ID: <54AA87EB.1000004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2015 05:39 PM, Sebastian Reichel wrote:

> On Sat, Jan 03, 2015 at 12:30:26PM -0600, Nishanth Menon wrote:
>> [...]
>> +		gpio-fan,speed-map = <0    0
>> +				      13000 1>;
>> [...]
>
> iirc DT maintainers prefer this format:
>
> gpio-fan,speed-map = <0     0>,
>                       <13000 1>;
>
> This should result in the same .dtb, but is a bit easier to read.
>
yes indeed.. :( Thanks for catching it. will repost.

Regards,
Nishanth Menon
