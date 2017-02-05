From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sun, 5 Feb 2017 09:19:25 +0000
Subject: [PATCH v2 0/5] Add Cavium ARCH_THUNDER2 platform
In-Reply-To: <db4646cc-b020-aa9f-7ab1-54bfca6e1588@gmail.com>
References: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
 <db4646cc-b020-aa9f-7ab1-54bfca6e1588@gmail.com>
Message-ID: <20170205091924.GA51205@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2017 at 07:11:17PM -0800, Florian Fainelli wrote:
> Le 02/04/17 ? 16:57, Jayachandran C a ?crit :
> > Here's the updated patchset, please let me know if thereare any
> > comments.  If a pull request is needed(with a public git tree), I
> > can set one up on github.
> > 
> > This patchset adds support for the new ThunderX2 CN99XX processor
> > family.
> > 
> > Changes are to add: the config option, the required device tree files,
> > the device tree bindings documentation and the defconfig entry.
> > 
> > Changes from v1 -> v2:
> > * split Kconfig.platforms changes and device tree changes
> > * Added MAINTAINERS entry
> 
> Does that mean support for Broadcom Vulcan should be removed then? If
> do, do you mind doing that?

I will send patches for removing ARCH_VULCAN once ARCH_THUNDER2 is
merged and the driver dependencies are updated by another set of patches.
Otherwise we have a problem (especially in distribution config files)
of not being able to select the drivers (for SPI, GPIO and I2C) for the
platform.

Thanks,
JC.
