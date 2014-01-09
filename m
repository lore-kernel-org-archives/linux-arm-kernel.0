From: robin.randhawa@arm.com (Robin Randhawa)
Date: Thu, 9 Jan 2014 15:06:40 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1389208330-12495-3-git-send-email-broonie@kernel.org>
References: <1389208330-12495-1-git-send-email-broonie@kernel.org>
 <1389208330-12495-3-git-send-email-broonie@kernel.org>
Message-ID: <20140109150640.GA7010@e106553-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark.

On 08/01/2014, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> In non-heterogeneous systems like big.LITTLE systems the scheduler will be

Minor nit: 'Heterogeneous systems' or 'non-homogeneous
systems' would be more appropriate.

Robin
