From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 16:29:53 -0700
Subject: [PATCH 1/9] ARM: dt: add header to define GPIO flags
In-Reply-To: <20130214.224816.1898594449880044716.hdoyu@nvidia.com>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org><1360791198-29462-2-git-send-email-swarren@wwwdotorg.org>
 <20130214.224816.1898594449880044716.hdoyu@nvidia.com>
Message-ID: <511D7371.6040603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 01:48 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 13 Feb 2013 22:33:10 +0100:
>> Many GPIO device tree bindings use the same flags. Create a header to
>> define those.
... [discussion about adding include guards]
> To avoid multple inclusion problems, do we want the above
> ifdef/define/endif for other DT header files as well?

Yes, we should probably add include guards to all the files. I'll update
my patch series.
