From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 11:36:19 -0700
Subject: [PATCH 01/31] ARM: tegra: add missing clock documentation to
 DT bindings
In-Reply-To: <20131129114900.GN22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
 <20131129114900.GN22771@ulmo.nvidia.com>
Message-ID: <529E24A3.3080804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 04:49 AM, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:53:56PM -0700, Stephen Warren wrote:
...
>> +  - clock-names : Must include the following entries:
> 
> One other thing I noticed here is that you use a space between the 
> property name and the :. None of the other properties have that, so
> it looks somewhat out of place. The same is true for other
> bindings, but there seem to be inconsistencies in some places
> anyway, so perhaps we don't care? Well, I do care, don't know about
> you. =)

I've fixed those up locally. I assume you don't want a repost for such
a trivial change? I'll double-check the "resets" patch for the same issue.
