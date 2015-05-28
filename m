From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 16:05:25 -0600
Subject: [PATCH 5/7] ARM: bcm2835: Drop the fixed sys_pclk.
In-Reply-To: <1431978219-14226-6-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-6-git-send-email-eric@anholt.net>
Message-ID: <55679125.6000607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2015 01:43 PM, Eric Anholt wrote:
> Nothing uses it, and I can't find any evidence that anything ever has.

Does the clock actually exist though? If it does, it seems reasonable to
keep it.
