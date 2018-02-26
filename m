From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Feb 2018 12:02:07 +0100
Subject: [PATCH] arm64: defconfig: enable R8A77965 SoC
In-Reply-To: <SN4PR0601MB3709B0D878715B944580EFCCC4CC0@SN4PR0601MB3709.namprd06.prod.outlook.com>
 <e10b7083-5148-0463-9ca9-1eb08483265e@mentor.com>
Message-ID: <20180226110207.k67jq2y7hxsmyfh4@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 05:27:30PM +0200, Vladimir Zapolskiy wrote:
> Hi Simon,
> 
> On 02/23/2018 10:51 AM, Simon Horman wrote:
> > Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 defconfig.
> 
> If I'm not mistaken in my tardy note, then M3-W is R8A7796 and R8A77965 is M3-N, no?

On Fri, Feb 23, 2018 at 03:29:08PM +0000, Yao Lihua wrote:
> On Friday, February 23, 2018 04:51 PM, Simon Horman wrote:
> > Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 defconfig.
> R8A77965 should be M3-N?

Thanks, I have fixed this up to read M3-N.
