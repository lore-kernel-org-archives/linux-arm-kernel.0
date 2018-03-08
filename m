From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Mar 2018 16:49:44 +0800
Subject: [PATCH v2 1/5] ARM: dts: vf500: Remove skeleton.dtsi inclusion
In-Reply-To: <1520116844-1145-1-git-send-email-festevam@gmail.com>
References: <1520116844-1145-1-git-send-email-festevam@gmail.com>
Message-ID: <20180308084942.GY3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2018 at 07:40:40PM -0300, Fabio Estevam wrote:
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
> Reviewed-by: Stefan Agner <stefan@agner.ch>

Applied all, thanks.
