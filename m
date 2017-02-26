From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 26 Feb 2017 13:45:56 -0800
Subject: [PATCH 1/2] devicetree: Add vendor prefix for Hwacom Systems Inc.
In-Reply-To: <20170222142558.wbedfw6l4maatkdy@rob-hp-laptop> (Rob Herring's
 message of "Wed, 22 Feb 2017 08:25:58 -0600")
References: <20170212193247.22705-1-carlo@caione.org>
 <20170212193247.22705-2-carlo@caione.org>
 <20170222142558.wbedfw6l4maatkdy@rob-hp-laptop>
Message-ID: <m2mvd839t7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Sun, Feb 12, 2017 at 08:32:46PM +0100, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>> 
>> Hwacom Systems Inc. is a broadband system integrator and supplier of
>> mobile, fixed and IP networks related services as well as
>> multimedia application. Website: http://www.hwacom.com/
>> 
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Rob, I assume I should take this patch along with the patch that's using
this prefix?  Or does this go through some other DT path?

Kevin
