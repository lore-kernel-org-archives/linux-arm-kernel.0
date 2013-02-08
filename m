From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 10:16:13 -0700
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <20130208140301.GA23979@arwen.pp.htv.fi>
References: <1360330602-30472-1-git-send-email-pdeschrijver@nvidia.com>
 <1360330602-30472-9-git-send-email-pdeschrijver@nvidia.com>
 <20130208140301.GA23979@arwen.pp.htv.fi>
Message-ID: <511532DD.2080306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 07:03 AM, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Feb 08, 2013 at 03:36:40PM +0200, Peter De Schrijver
> wrote:
>> tegra_car: clock { -		compatible = "nvidia,tegra114-car,
>> nvidia,tegra30-car"; +		compatible = "nvidia,tegra114-car";
> 
> trailing change or intentional ?

I believe it's intentional since the HW isn't fully
backwards-compatible. However, the commit description should mention this.
