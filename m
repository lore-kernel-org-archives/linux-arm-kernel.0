From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 11:46:54 -0600
Subject: [PATCH 1/4] ARM: tegra: use #include for all device trees
In-Reply-To: <1368473072-10145-1-git-send-email-swarren@wwwdotorg.org>
References: <1368473072-10145-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <519A618E.4040400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 01:24 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Replace /include/ (dtc) with #include (C pre-processor) for all Tegra DT
> files, so that gcc -E handles the entire include tree, and hence any of
> those files can #include some other file e.g. for constant definitions.
> 
> This allows future use of #defines and header files in order to define
> names for various constants, such as the IDs and flags in GPIO
> specifiers. Use of those features will increase the readability of the
> device tree files.

I have applied this series, with patch 3/4 replaced with V3 of that patch.
