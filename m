From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 08:36:06 +0530
Subject: [PATCH 1/8] DMA: PL330: use prefix in reg names to build under x86
In-Reply-To: <1347639843-32119-2-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
 <1347639843-32119-2-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <1347851166.1943.122.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 18:23 +0200, Davide Ciminaghi wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
> 
> This driver would not compile if ARM_AMBA is selected under x86,
> because "CS" and "DS" are already defined there.  But AMBA
> is used in the x86 world by a PCI-to-AMBA bridge, to be submitted.
> 
> The patch adds the "PL330_" prefix to all register and bit fields,
> so it can be built by randomconfig after ARM_AMBA appears within x86.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> ---
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
