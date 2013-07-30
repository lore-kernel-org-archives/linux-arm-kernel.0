From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Tue, 30 Jul 2013 22:33:30 +0900
Subject: [PATCH 4/5] mmc: dw_mmc: Indicate that regulators may be absent
In-Reply-To: <1375184777-25404-4-git-send-email-broonie@kernel.org>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
 <1375184777-25404-4-git-send-email-broonie@kernel.org>
Message-ID: <003901ce8d29$610ab3f0$23201bd0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, July 30, 2013, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Use regulator_get_optional() to tell the core that requests for regulators
> can fail in a real system.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
