From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Jan 2015 14:00:43 -0700
Subject: [PATCH 4/4] clk: tegra: Add support for the Tegra132 CAR IP block
In-Reply-To: <alpine.DEB.2.02.1501092030180.28771@utopia.booyaka.com>
References: <20141216203813.22980.2301.stgit@chromeos-P9X79>
 <20141216203829.22980.64446.stgit@chromeos-P9X79>
 <20150109111954.GB16465@ulmo>
 <alpine.DEB.2.02.1501092030180.28771@utopia.booyaka.com>
Message-ID: <54B0417B.6030409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2015 01:52 PM, Paul Walmsley wrote:
> Hi Thierry
>
> On Fri, 9 Jan 2015, Thierry Reding wrote:
>
>> On Tue, Dec 16, 2014 at 12:38:29PM -0800, Paul Walmsley wrote:
>>>
>>> This patch is based on several patches from others:
>>>
>>> 1. a  patch from Peter De Schrijver:
>>>
>>> http://lkml.iu.edu/hypermail/linux/kernel/1407.1/06094.html
>>>
>>> 2. a patch from Bill Huang ("clk: tegra: enable cclk_g at boot on
>>> Tegra132"), and
>>>
>>> 3. a patch from Allen Martin ("clk: Enable tegra clock driver for
>>> tegra132").
>>
>> Doesn't this technically require Signed-off-bys from each of the above,
>> then?
>
> I don't think so.  Documentation/SubmittingPatches states:

It's certainly been deemed acceptable in the past, if admittedly not 
optimal, for the person who is the "exit point" of an 
organization/company for the patch to be the only person to sign it off. 
The reason being they're vouching that the Certificate of Origin applies 
to all the company-sponsored work internal to the organization.
