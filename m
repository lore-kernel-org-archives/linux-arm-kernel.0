From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 9 Nov 2015 08:17:38 -0700
Subject: [PATCH v4] Tegra: DT: add device tree binding doc for QSPI
In-Reply-To: <20151109124545.GD23941@ulmo.nvidia.com>
References: <1445898140-3561-1-git-send-email-twarren@nvidia.com>
 <562EB11D.5040706@wwwdotorg.org> <20151109124545.GD23941@ulmo.nvidia.com>
Message-ID: <5640B912.3070207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2015 05:45 AM, Thierry Reding wrote:
> On Mon, Oct 26, 2015 at 05:02:53PM -0600, Stephen Warren wrote:
>> On 10/26/2015 04:22 PM, Tom Warren wrote:
>>> This patch adds the device tree binding doc for the Tegra
>>> QSPI controller on Tegra210.
>>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>>
>> (I assume if others approve the binding, Thierry will take it through the
>> Tegra tree)
>
> Do we have a kernel driver and hardware where this can be tested? I'm
> slightly reluctant to merge a binding through the Tegra tree without a
> driver that implements it.

AFAIK, the only HW this can be tested on is a one-off modified version 
of p2571. The standard boards don't have this. I don't believe there's 
an (upstream at least) kernel driver for this. I'm sure downstream has a 
driver.
