From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 13:07:10 +0100
Subject: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
In-Reply-To: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <3596300.IYfzmako0c@wuerfel> <20160128031435.GA25625@wfg-t540p.sh.intel.com>
Message-ID: <1889851.3PhZkL3YD7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 January 2016 11:14:35 Fengguang Wu wrote:

> > - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
> >   in 'make config'
> 
> That's a problem for auto tests.

Ok, I'll try to revisit this one. Maybe I can turn it into a
'default 0xffffffff' with a compile-time warning, or make
'default 0' the fallback when it's not specified otherwise.

	Arnd
