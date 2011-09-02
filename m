From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Sep 2011 15:33:29 +0300
Subject: [PATCH 0/4] OMAP2: clockdomain/powerdomain: remove OMAP_CHIP
	bitmasks
In-Reply-To: <20110902021321.8185.63172.stgit@dusk>
References: <20110902021321.8185.63172.stgit@dusk>
Message-ID: <20110902123328.GW3548@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110902 04:58]:
> Remove the OMAP_CHIP bitmasks from the powerdomain and clockdomain
> code.  In their place, use lists of powerdomains and clockdomains to
> register for particular chips and chip families.
> 
> The intention of this change is to reduce the number of lines that
> need to be patched to add support for new SoCs that are similar to
> previous SoCs.
> 
> This series has been boot-tested on a 2430SDP, BeagleBoard 35xx and
> 37xx, and PandaBoard 44xxES2, but I don't have boards for all of the
> different variants needed for a complete test.
> 
> A git branch is available at git://git.pwsan.com/linux-2.6 based on
> v3.1-rc4 with prcm-fixes-a-3.1rc.

Great! Thanks for working on this. Let's get this tested and merged
into our cleanup branch ASAP as this will simplify adding new omaps
quite a bit :)

Tony
