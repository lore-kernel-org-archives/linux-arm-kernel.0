From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 11:29:34 -0700
Subject: [PATCHv7 01/12] of: introduce
 of_property_for_each_phandle_with_args()
In-Reply-To: <1386835033-4701-2-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF468E.1050602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> Iterating over a property containing a list of phandles with arguments
> is a common operation for device drivers. This patch adds a new
> of_property_for_each_phandle_with_args() macro to make the iteration
> simpler.

This version looks good to me.
Reviewed-by: Stephen Warren <swarren@nvidia.com>

But if you want to rewrite it to use a struct to store state between
_init()/_iter(), that'd probably be fine too.
