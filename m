From: khilman@kernel.org (Kevin Hilman)
Date: Sun, 12 Oct 2014 05:57:05 -0700
Subject: [PATCH v1 2/4] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <542DA4D4.4070202@ti.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
 <1412001499-19369-3-git-send-email-grygorii.strashko@ti.com>
 <542DA4D4.4070202@ti.com>
Message-ID: <CAMAWPa96Kqg8r3GqJQoiSTspFnHo3gnWxzBtCpei7-nCXN+Dzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/2/14 12:17 PM, Santosh Shilimkar wrote:
> On Monday 29 September 2014 10:38 AM, Grygorii Strashko wrote:
>> This patch switches Keystone 2 PM code to use Generic PM domains
>> instead of PM clock domains because of the lack of DT support
>> for the last.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---

[...]

>> Other than that patch looks fine to me. If Kevin is happy
>> with overall approach then we can proceed with this.

Looks good to me:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
