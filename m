From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 May 2014 21:31:16 +0200
Subject: [PATCHv5 3/5] clk: samsung: exynos3250: Add clocks using common
 clock framework
In-Reply-To: <1399986308-23744-4-git-send-email-cw00.choi@samsung.com>
References: <1399986308-23744-1-git-send-email-cw00.choi@samsung.com>
 <1399986308-23744-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <5373C484.8050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 13.05.2014 15:05, Chanwoo Choi wrote:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> This patch add new the clock drvier of Exynos3250 SoC based on Cortex-A7
> using common clock framework. The CMU (Clock Management Unit) of Exynos3250
> control PLLs(Phase Locked Loops) and generate system clocks for CPU, buses,
> and function clocks for individual IPs.

Applied with few minor fixups.

Best regards,
Tomasz
