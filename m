From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 18:42:33 +0200
Subject: DEBUG_LL broken for socfpga
In-Reply-To: <1351186792.15182.14.camel@dinh-ubuntu>
References: <20121025181823.6c3fa0de@skate>
 <1351186792.15182.14.camel@dinh-ubuntu>
Message-ID: <20121025184233.0883d4dc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On Thu, 25 Oct 2012 11:39:52 -0600, Dinh Nguyen wrote:

> Doesn't this patch address the fix?
> 
> in arm-soc for-next
> commit  ef3f94412a4d7e107392e7c7cfc3e2d0668aa1aa
> 
> http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commit;h=ef3f94412a4d7e107392e7c7cfc3e2d0668aa1aa

Indeed, it fixes the problem. I was looking at 3.7-rc2, and forgot to
check in arm-soc/for-next before reporting the issue.

Sorry for the noise.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
