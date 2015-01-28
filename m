From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 28 Jan 2015 07:41:39 -0800
Subject: [PATCH 1/2] ARM: zynq: Remove bogus value from 'bias-disable'
 property
In-Reply-To: <ce6e56872ab744a49612ef9bca07c73d@BN1AFFO11FD005.protection.gbl>
References: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
 <54C6DDE8.3000905@suse.de>
 <ce6e56872ab744a49612ef9bca07c73d@BN1AFFO11FD005.protection.gbl>
Message-ID: <421020c5dac8492ea949dc202441c184@BL2FFO11FD054.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-01-28 at 03:21PM +0100, Michal Simek wrote:
> On 01/27/2015 01:38 AM, Andreas F?rber wrote:
> > Am 26.01.2015 um 20:49 schrieb Soren Brinkmann:
> >> In one pinctrl node, a 'bias-disable' property is erroneously assigned a
> >> value.
> >>
> >> Fixes: ARM: zynq: DT: Add pinctrl information
> >> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > 
> > Reviewed-by: Andreas F?rber <afaerber@suse.de>
> > 
> > Andreas
> > 
> 
> Applied both.

Thanks. Given how the branch looks now, you could squash 'ARM: zynq: DT:
Remove bogus value from 'bias-disable' property' and 'ARM: zynq: DT: Add
pinctrl information to USB nodes' into 'ARM: zynq: DT: Add pinctrl
information'. Then we have it all in one patch and spare everybody the
intermittent, partly broken commits.

	S?ren
