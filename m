From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 21:41:15 -0700
Subject: [PATCH] ARM: bcm2835: Fix grammar in help message
In-Reply-To: <1386271060-2375-1-git-send-email-sw@weilnetz.de>
References: <1386271060-2375-1-git-send-email-sw@weilnetz.de>
Message-ID: <52A2A6EB.8040207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 12:17 PM, Stefan Weil wrote:
> Replace "is use" by "is used" and remove a comma.

Applied to bcm2835's for-3.14/soc branch.

(I'm not convinced about the
serial-comma-applies-to-lists-of-three-or-more-items rule, since two
items are clearly a list, and it's inconsistent with what I recall
seeing in practice, but anyway).
