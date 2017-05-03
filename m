From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 21:42:54 +0800
Subject: [PATCH V5 7/7] ARM: ZTE: Use - instead of @ for DT OPP entries
In-Reply-To: <5534c08d8b452c8ce623d3e465603d94afd82ed4.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <5534c08d8b452c8ce623d3e465603d94afd82ed4.1492685450.git.viresh.kumar@linaro.org>
Message-ID: <20170503134252.GA24745@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 04:25:11PM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Changed the subject prefix to 'arm64: dts: zte: ', and applied the
patch.

Shawn
