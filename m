From: rklein@nvidia.com (Rhyland Klein)
Date: Tue, 12 Feb 2013 13:30:30 -0500
Subject: [PATCH 1/2] pinctrl: tegra: add clfvs function to Tegra114 support
In-Reply-To: <511A6EE8.7010301@nvidia.com>
References: <1360621513-18814-1-git-send-email-rklein@nvidia.com>
 <5119829C.20400@wwwdotorg.org> <511A6EE8.7010301@nvidia.com>
Message-ID: <511A8A46.2010701@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2013 11:33 AM, Rhyland Klein wrote:
> On 2/11/2013 6:45 PM, Stephen Warren wrote:
>> On 02/11/2013 03:25 PM, Rhyland Klein wrote:
>>> This patch adds the definition for the cldvfs function for Tegra114 pinctrl
>>> support. This is based on work by Pritesh Raithatha.
>> Sorry I forgot about this before, but
>> Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.txt
>> needs to be updated too.
>>
>> Aside from that,
>>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> thanks, I'll add that and send new rev.
>
> --rhyland
>
After looking, the devicetree binding doc don't seem to list the valid 
functions. This change adds a function, and the other groups similar 
(blink, cec, ...) don't seem to be listed either. Is there something 
else that should be changed in the binding doc that I am missing?

-rhyland

-- 
nvpublic
