From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Apr 2010 14:44:59 +0100
Subject: [PATCH 1/3] WM8750: Convert to new API
In-Reply-To: <1270440818-25790-1-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
	<1270440818-25790-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100405134459.GE6580@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 05, 2010 at 06:13:36AM +0200, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

This looks good too, modulo the issue with needing to handle all the
existing machine drivers.
