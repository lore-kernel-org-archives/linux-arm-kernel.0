From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Sep 2013 12:25:06 -0600
Subject: [PATCH v4 0/5] ARM: tegra: support for Trusted Foundations
In-Reply-To: <52269B92.3070304@nvidia.com>
References: <1377770268-14014-1-git-send-email-acourbot@nvidia.com>
 <52262D8F.9060706@wwwdotorg.org> <52269B92.3070304@nvidia.com>
Message-ID: <52277B02.9010707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2013 08:31 PM, Alex Courbot wrote:
> On 09/04/2013 03:42 AM, Stephen Warren wrote:
>> On 08/29/2013 03:57 AM, Alexandre Courbot wrote:
>>> New version revised according to comments received for v3. Hopefully
>>> it will be good enough to be merged.
>>
>> Aside from the small issue in patch 1/5, the series,
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> Thanks! I have adressed the issues you mentioned and will submit v5
> soon. Despite the fact this adds some non-Tegra stuff, will you be able
> to take it into your tree, or should I ask someone else?

I would like to see an ack from the core ARM maintainer (Russell) on
patch 1/5 (also CC'ing arm-soc maintainers for their opinion).

If I get that, I think it makes sense to take the series through the
Tegra tree. I can always create a stable branch for patch 1/5 if needed
to resolve conflicts elsewhere (e.g. Russell's trees or arm-soc) and/or
allow other people to build on top of that patch.
