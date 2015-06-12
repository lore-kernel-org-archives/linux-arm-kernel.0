From: fengguang.wu@intel.com (Fengguang Wu)
Date: Fri, 12 Jun 2015 09:00:26 +0800
Subject: [PATCH v3] dmaengine: xgene-dma: Fix sparse wannings and
 coccinelle warnings
In-Reply-To: <CANeU7Q=0VT5EOjKXEFJ4WgKQGcZhufEgksLoN4PDLEbc+q0pgQ@mail.gmail.com>
References: <1429212673-22254-1-git-send-email-rsahu@apm.com>
 <20150417182937.GN30624@intel.com>
 <CAFd313y-HfW_us0FVQFEkGAzf-ZCKpRtF6eYweaK0V94MBg4iQ@mail.gmail.com>
 <20150427031315.GG2738@intel.com>
 <20150427052045.GA5199@wfg-t540p.sh.intel.com>
 <CANeU7Q=0VT5EOjKXEFJ4WgKQGcZhufEgksLoN4PDLEbc+q0pgQ@mail.gmail.com>
Message-ID: <20150612010026.GA14406@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 05:36:00PM -0700, Christopher Li wrote:
> n Sun, Apr 26, 2015 at 10:20 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> >> >
> >> > drivers/dma/xgene-dma.c:2088:1: sparse: symbol
> >> > '__UNIQUE_ID_author__COUNTER__' has multiple initializers (originally
> >> > initialized at drivers/dma/xgene-dma.c:2087)
> >> > So, I kept only one author here.
> >> No that is not right, sparse shouldn't have cribbed here.
> >>
> >> Fengguang can we get the bot to ignore this please
> 
> Sorry for the late reply.
> 
> That looks like the __COUNTER__ macro feature. It has been implemented in
> sparse git tree already.

That's great, I'll fetch the latest sparse code from

git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

Thanks,
Fengguang
