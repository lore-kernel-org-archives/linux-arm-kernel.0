From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 09:51:27 -0600
Subject: [PATCH 1/5] ARM: tegra: Add pllc clock init table
In-Reply-To: <20120415003303.GA10967@quad.lixom.net>
References: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
 <20120415003303.GA10967@quad.lixom.net>
Message-ID: <4F8C3FFF.1050104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2012 06:33 PM, Olof Johansson wrote:
> On Fri, Apr 13, 2012 at 04:42:02PM -0600, Stephen Warren wrote:
>> From: Allen Martin <amartin@nvidia.com>
>>
>> (cherry picked from commit 54f28b336f2ba3da93a459d22e32944823960d08
>> in the chromeos-2.6.38 kernel)
>>
>> swarren adds:
> 
> The above 4 lines make no sense for upstream, so you can just say "from the
> Chrome OS 2.6.38 tree" or similar.

I tend to disagree; I'd love to see some tie between downstream and
upstream repositories so that people working on both downstream and
upstream kernels can tie the two together much more easily. And, the
chromeos tree is well known amongst those working on Tegra, and publicly
accessible.

Still, I guess we haven't followed this practice on commits before, so
it would be inconsistent to include this, unless we resolved to be
diligent about this going forward.

So, I'll remove it.
