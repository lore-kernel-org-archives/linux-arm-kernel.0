From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 1 Mar 2018 08:45:59 +0800
Subject: [PATCH 1/5] ARM: dts: vf500: Remove skeleton.dtsi inclusion
In-Reply-To: <1519755447-9666-1-git-send-email-festevam@gmail.com>
References: <1519755447-9666-1-git-send-email-festevam@gmail.com>
Message-ID: <20180301004552.GP3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 03:17:23PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as
> deprecated") the inclusion of skeleton.dtsi is deprecated, so
> remove it as this file will eventually go away someday.
> 
> Move its content to the SoC dtsi file, so that the resultant dtb
> is the same.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Stefan, please take a look at the series.

Shawn
