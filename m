From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 14 May 2018 10:34:55 +0200
Subject: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180514083455.GE29062@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 04:09:17PM +0800, Anson Huang wrote:
> This patch removes cpufreq cooling registration in
> thermal .probe function, cpufreq cooling should be
> done in cpufreq driver when it is ready.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
