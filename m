From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 May 2018 00:19:13 +0800
Subject: [PATCH 01/21] dt-bindings: clock: Add compatible for A64 DE2 CCU
In-Reply-To: <20180501161618.GA32350@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-2-jagan@amarulasolutions.com>
 <20180501161618.GA32350@rob-hp-laptop>
Message-ID: <CAGb2v64ZTQ0jAaSpDXtV58c-EE2FMMbVASLLjxjGkWM3iJTMHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 12:16 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Apr 30, 2018 at 05:10:38PM +0530, Jagan Teki wrote:
>> Allwinner A64 has DE2 CCU which is similar to H3/H5 SoC.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Rob,

Do we need to add this if it's just a soc-specific compatible
we add in the device tree to future proof things in case we
discover quirks later on?

AFAIK we haven't been doing this, and this is likely to create
some confusion, because they aren't actually mentioned anywhere
in the driver.

ChenYu
