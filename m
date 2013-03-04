From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Mar 2013 10:13:57 -0700
Subject: [PATCH 1/9] ARM: dt: add header to define GPIO flags
In-Reply-To: <20130304083457.0D4333E206B@localhost>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
 <1360791198-29462-2-git-send-email-swarren@wwwdotorg.org>
 <20130304083457.0D4333E206B@localhost>
Message-ID: <5134D655.9070608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 01:34 AM, Grant Likely wrote:
> On Wed, 13 Feb 2013 14:33:10 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Many GPIO device tree bindings use the same flags. Create a header to
>> define those.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  arch/arm/boot/dts/gpio.h |   10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/gpio.h
>>
>> diff --git a/arch/arm/boot/dts/gpio.h b/arch/arm/boot/dts/gpio.h
>> new file mode 100644
>> index 0000000..4c9da69
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/gpio.h
> 
> Stephen, you know better than this. This is common code. Don't put it
> under arch/arm.

In V2 of the patch which modifies the dtc+cpp include path:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-February/028591.html

... I have moved the common headers to top-level include/dt-bindings, so
it is shared across all arch. I didn't repost all the changes to the *.h
and *.dts* files yet; I was waiting for any comments on the patch above.
