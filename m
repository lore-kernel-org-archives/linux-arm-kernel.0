From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Oct 2013 09:23:55 -0600
Subject: [PATCH] clk: tegra: PLLE spread spectrum control
In-Reply-To: <20131003105228.GK3973@tbergstrom-lnx.Nvidia.com>
References: <1380209654-25458-1-git-send-email-pdeschrijver@nvidia.com>
 <524B28EA.40702@wwwdotorg.org>
 <20131003105228.GK3973@tbergstrom-lnx.Nvidia.com>
Message-ID: <524D8C0B.90707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2013 04:52 AM, Peter De Schrijver wrote:
> On Tue, Oct 01, 2013 at 09:56:26PM +0200, Stephen Warren wrote:
>> On 09/26/2013 09:34 AM, Peter De Schrijver wrote:
>>> Add spread spectrum control for PLLE in Tegra114.
>>
>> It would be useful to have some description of the end-user-visible
>> benefit of this change; why is it useful?
> 
> spread spectrum clocking is a technique to reduce EMI caused by the clock
> signal by modulating the frequency with a low frequency signal. This should
> reduce interference with eg. Wifi or cellular modems on the same board.

Great. The intent of my request was for that information to be included
in the patch description.
