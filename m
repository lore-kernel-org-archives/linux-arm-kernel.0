From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:45:17 +0100
Subject: [PATCH 10/18] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <1343393162-11938-11-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-11-git-send-email-lee.jones@linaro.org>
Message-ID: <20120729204516.GJ4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:45:54PM +0100, Lee Jones wrote:
> The current kernel commandline for ux500 based devices includes
> hard-coded allocations for things like mali and hwmem, which
> actually run over lowmem. Here we enable highmem in order to
> avoid memory corruption errors.

This appears to be at best tangentially related to the rest of the
series, are you sure it shouldn't be being sent separately as a bugfix?
