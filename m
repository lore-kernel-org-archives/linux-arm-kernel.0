From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Fri, 13 Feb 2015 12:19:30 +0200
Subject: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <20150212135440.GG20811@tbergstrom-lnx.Nvidia.com>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
 <20150212135440.GG20811@tbergstrom-lnx.Nvidia.com>
Message-ID: <54DDCFB2.9070800@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2015 03:54 PM, Peter De Schrijver wrote:
> On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
>> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>>
>> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
>> and also provides automatic CPU rail voltage scaling as well. The DFLL
>> is a separate IP block from the usual Tegra124 clock-and-reset
>> controller, so it gets its own node in the device tree.
>>
>
> Please add devicetree at vger.kernel.org to the next CC list.

Will do. Thanks for the acks!

>
> Peter.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
