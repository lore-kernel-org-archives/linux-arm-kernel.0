From: carlo@caione.org (Carlo Caione)
Date: Mon, 10 Feb 2014 23:38:47 +0100
Subject: [linux-sunxi] Re: [PATCH 3/3] mfd: axp20x: Add bindings
 documentation
In-Reply-To: <20140210220102.GG3192@lukather>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-4-git-send-email-carlo@caione.org>
 <20140210201215.GC3192@lukather>
 <CAOQ7t2YBhUuVQuDhkCux4ogb8_W2Ja1RMn4+UtcUpYrR84Boug@mail.gmail.com>
 <20140210220102.GG3192@lukather>
Message-ID: <CAOQ7t2ZT-3OnG-1BjGS9c6jdbzt1rDHRQ9ptOaXbewypiG_oBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:01 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Feb 10, 2014 at 09:37:37PM +0100, Carlo Caione wrote:
>> >> +Sub-nodes
>> >> +* regulators : Contain the regulator nodes. The regulators are bound using
>> >> +            their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
>> >> +            ldo4, ldo5.
>> >> +            The bindings details of individual regulator device can be found in:
>> >> +            Documentation/devicetree/bindings/regulator/regulator.txt with the
>> >> +            exception of:
>> >
>> > I'm guessing this is where you differentiate between AXP202 and
>> > AXP209?
>>
>> Not really. AXP202 and AXP209 have the same regulators (with the same
>> constrains)
>
> Ok. What's the difference between the two then?

Honestly I have no idea. For what I have seen (core, PEK and
regulators) AXP202 and AXP209 are identical.

-- 
Carlo Caione
