From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Nov 2013 11:46:54 +0000
Subject: [PATCH 3/7] ARM: ux500: Remove ATAG support for SDI (MMC)
In-Reply-To: <1383732348-18576-4-git-send-email-lee.jones@linaro.org>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
 <1383732348-18576-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20131107114654.GF16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:05:44AM +0000, Lee Jones wrote:
> This hasn't been used since we moved over to a Device Tree only platform.

The patch summary line is slightly off.  There's nothing here to do with
ATAGs.
