From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 13 Jun 2012 18:26:58 +0300
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120613152658.GE32111@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 04:41:47PM +0200, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series defines clock bindings for Device-Tree and adds kernel
> support using the common clock infrastructure. The last patch enables
> DT clock support for the Calxeda Highbank platform.
> 
> I'm posting this again to solicit further review. There has been some
> discussion[1], but no definite path forward. This series is not changed
> from the last post other than rebasing to v3.5-rc2.
> 
> Rob
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/100932.html
> 

How would this binding work for clocks which can take a spinlock pointer as a
init parameter (eg. clk-gate).

Cheers,

Peter.
