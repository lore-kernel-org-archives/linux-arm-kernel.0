From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 10:10:16 -0700
Subject: [v3 0/6] ARM: tegra: convert device tree files to use CLK defines
In-Reply-To: <1361138717.29465.2@driftwood>
References: <1360917814-27236-1-git-send-email-hdoyu@nvidia.com>
 <1361138717.29465.2@driftwood>
Message-ID: <5123B1F8.4040102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2013 03:05 PM, Rob Landley wrote:
> On 02/15/2013 02:43:11 AM, Hiroshi Doyu wrote:
>> Hi,
>>
>> With new dtc+cpp feature, we could get rid of magic numbers in dts*
>> files. This patch replaces CLK IDs.
>>
>> We also plan to share those DT header files with kernel source
>> later[1].
> ...
>> [1]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149804.html
>>
> 
> This really smells like documentation should be updated, probably
> booting-without-of.txt or similar. Alas, I'm not capable of writing such
> an update...

I'm not sure what documentation would be updated nor why. Can you
describe that?

This patch is (or should be) editing the device tree binding
documentation to (include by) reference the header file that is being
added in this patch. I don't believe there's any more general
documentation that is affected by this series.
