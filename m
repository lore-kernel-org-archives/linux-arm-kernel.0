From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Mar 2013 14:34:53 -0600
Subject: [PATCH 2/2] ARM: tegra: use CS_LAR_KEY definition instead of
 0xC5ACCE55
In-Reply-To: <1364235552-17851-2-git-send-email-will.deacon@arm.com>
References: <1364235552-17851-1-git-send-email-will.deacon@arm.com>
 <1364235552-17851-2-git-send-email-will.deacon@arm.com>
Message-ID: <5152066D.8080804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 12:19 PM, Will Deacon wrote:
> When enabling coresight on secondary cores for tegra, make use of our
> fancy new definition for the magic lock code.

The code you're editing has actually been removed in the 3.10 cycle, so
there's no need for this patch any more.
