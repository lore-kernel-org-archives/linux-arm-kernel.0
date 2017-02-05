From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 4 Feb 2017 19:11:17 -0800
Subject: [PATCH v2 0/5] Add Cavium ARCH_THUNDER2 platform
In-Reply-To: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
References: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <db4646cc-b020-aa9f-7ab1-54bfca6e1588@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/04/17 ? 16:57, Jayachandran C a ?crit :
> Here's the updated patchset, please let me know if thereare any
> comments.  If a pull request is needed(with a public git tree), I
> can set one up on github.
> 
> This patchset adds support for the new ThunderX2 CN99XX processor
> family.
> 
> Changes are to add: the config option, the required device tree files,
> the device tree bindings documentation and the defconfig entry.
> 
> Changes from v1 -> v2:
> * split Kconfig.platforms changes and device tree changes
> * Added MAINTAINERS entry

Does that mean support for Broadcom Vulcan should be removed then? If
do, do you mind doing that?
-- 
Florian
