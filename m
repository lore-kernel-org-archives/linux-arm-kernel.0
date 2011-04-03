From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 3 Apr 2011 22:18:16 +0900
Subject: [PATCH 1/3] sound/spitz: Properly handle MIC GPIO
In-Reply-To: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
References: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20110403131814.GB17566@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2011 at 03:43:15AM +0200, Marek Vasut wrote:
> This patch firstly restructurizes the code a bit by getting rid of continuous
> checking for machine type in spitz_mic_bias().
> 
> Then the patch properly requests the MIC GPIO in the spitz_init() and frees it
> in spitz_exit().
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied, thanks.
