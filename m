From: fengguang.wu@intel.com (Fengguang Wu)
Date: Fri, 5 Jun 2015 11:53:13 +0800
Subject: [RFT v2 00/48] Refine irq interfaces to reduce number of
 parameters
In-Reply-To: <CAMuHMdUfGMU3m35xWD9vE1RNW80jjHx_KLM3a4GWq=JfuGcGBw@mail.gmail.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <CAMuHMdUfGMU3m35xWD9vE1RNW80jjHx_KLM3a4GWq=JfuGcGBw@mail.gmail.com>
Message-ID: <20150605035313.GA7707@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The patch set passes Fengguang's 0day test suites as below. And tests
> > with other platforms and configurations will be appreciated:)
> > ----------------------------------------------------------
> > configs tested: 95
> 
> [...]
> 
> > m68k                          amiga_defconfig
> > m68k                       m5475evb_defconfig
> > m68k                          multi_defconfig
> 
> For Fengguang: amiga_defconfig is a subset of multi_defconfig.
> But sun3_defconfig is distinct, as Sun-3 has a different MMU and thus support
> for it cannot be included in multi-platform kernels.
> So I think you better replace amiga_defconfig by sun3_defconfig for build tests.

Got it and changed the code accordingly, thank you for the suggestion!

Thanks,
Fengguang
