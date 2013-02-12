From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 11:54:05 -0700
Subject: [PATCH 1/2] pinctrl: tegra: add clfvs function to Tegra114 support
In-Reply-To: <511A8A46.2010701@nvidia.com>
References: <1360621513-18814-1-git-send-email-rklein@nvidia.com>
 <5119829C.20400@wwwdotorg.org> <511A6EE8.7010301@nvidia.com>
 <511A8A46.2010701@nvidia.com>
Message-ID: <511A8FCD.5080402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 11:30 AM, Rhyland Klein wrote:
> On 2/12/2013 11:33 AM, Rhyland Klein wrote:
>> On 2/11/2013 6:45 PM, Stephen Warren wrote:
>>> On 02/11/2013 03:25 PM, Rhyland Klein wrote:
>>>> This patch adds the definition for the cldvfs function for Tegra114
>>>> pinctrl
>>>> support. This is based on work by Pritesh Raithatha.
>>> Sorry I forgot about this before, but
>>> Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.txt
>>> needs to be updated too.
>>>
>>> Aside from that,
>>>
>>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> thanks, I'll add that and send new rev.
>
> After looking, the devicetree binding doc don't seem to list the valid
> functions. This change adds a function, and the other groups similar
> (blink, cec, ...) don't seem to be listed either. Is there something
> else that should be changed in the binding doc that I am missing?

Oh right, so they don't. They really should though, so could you please
file an internal bug to get the list of function added.

If there are groups missing from the list of valid groups, they should
be added too.

However, all that is unrelated to this patch series, so consider my
previous Reviewed-by to apply to the series as-is.

LinusW, I assume you will apply patch 1/2 to your pinctrl tree, and I'll
apply patch 2/2 to the Tegra tree later.
