From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Feb 2014 22:05:29 -0700
Subject: [PATCH 1/2] ARM: bcm2835: fix DT node sort order
In-Reply-To: <1392181392-29694-1-git-send-email-swarren@wwwdotorg.org>
References: <1392181392-29694-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52FB0119.1060803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 10:03 PM, Stephen Warren wrote:
> Re-order all the DT nodes so that they're ordered by their reg address.

I've applied this series to bcm2835's for-3.15/dt branch.
