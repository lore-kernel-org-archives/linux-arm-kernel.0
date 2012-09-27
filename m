From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 27 Sep 2012 07:40:38 +0200
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120927054038.GL17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:06 Tue 25 Sep     , Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This series adds some build rules to run cpp on *.dts-cpp prior to
> invoking dtc, and converts Tegra to the new rule as an example. What do
> people think?
> 
> I assume that you've applied the dtc patches I sent yesterday. They
> aren't in this series. See:
> 
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020182.html
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020183.html
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020181.html
> 
> Note: those patches are against upstream dtc. If you wish to test this
> series, apply the dtc patches to upstream dtc, build it, and copy the
> resultant dtc binary over the top of scripts/dtc/dtc.
> 
> Stephen Warren (3):
>   kbuild: introduce cmd_dtc_cpp
>   ARM: use cmd_dtc_cpp for compilation of *.dts-cpp to *.dtb
>   ARM: tegra: compile all DT files with cpp 
I do not like the extention

can we run gcc everytime?

or just do as done for lds

*.dts.S

Best Regards,
J.
