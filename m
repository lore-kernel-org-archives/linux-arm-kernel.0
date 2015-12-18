From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 18 Dec 2015 17:44:37 +0300
Subject: [PATCH v6 08/20] arm64: ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
In-Reply-To: <20151218141112.GD31200@yury-N73SV>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-9-git-send-email-ynorov@caviumnetworks.com>
 <20151217114153.GD25232@e104818-lin.cambridge.arm.com>
 <20151218141112.GD31200@yury-N73SV>
Message-ID: <20151218144437.GA4007@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 05:11:12PM +0300, Yury Norov wrote:
> On Thu, Dec 17, 2015 at 11:41:53AM +0000, Catalin Marinas wrote:
> > On Wed, Dec 16, 2015 at 12:42:34AM +0300, Yury Norov wrote:
> > > Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> > > Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > > Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> > 
> > Long description missing.
> 
> Hi, Catalin,
> 
> I think this patch (and patch #3 too) is trivial, and
> explanation in patch name is clear enougth. So, I just do not
> understand what else to explain here. Could you point me, and then I
> will do it.
> 

Is it OK?

arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64

ILP32 tasks are needed to be distinguished from lp64 and aarch32.
This patch adds helper functions is_ilp32_compat_{task,thread} and
thread flag TIF_32BIT_AARCH64 to address this. This patch is
preparation for following patches in ilp32 patchset.
