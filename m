From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 6 Dec 2011 16:28:00 +0000
Subject: [PATCH v2] ARM: pl2x0/pl310: Refactor Kconfig to be more
 maintainable
In-Reply-To: <4ED694C7.6020502@gmail.com>
References: <1322675975-4471-1-git-send-email-dave.martin@linaro.org>
 <4ED694C7.6020502@gmail.com>
Message-ID: <20111206162800.GF13769@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 02:40:39PM -0600, Rob Herring wrote:
> On 11/30/2011 11:59 AM, Dave Martin wrote:
> > Making CACHE_L2X0 depends on (huge list of MACH_ and ARCH_ configs)
> > is bothersome to maintain and likely to lead to merge conflicts.
> > 
> > This patch moves the knowledge of which platforms have a L2x0 or
> > PL310 cache controller to the individual machines.  To enable this,
> > a new HAVE_L2X0_L2CC config option is introduced to allow machines
> > to indicate that they have such a cache controller independently of
> > each other.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> > Changes since v1:
> > 
> > v2: Add HAVE_L2X0_L2CC instead of CACHE_L2X0 for SOC_IMX6Q.
> >     (Thanks to Shawn Guo for suggesting this.)
> > 
> 
> Did you not see my comments on v1?

See my separate reply -- it looks like I somehow missed you mail on the
previous iteration.

Cheers
---Dave
