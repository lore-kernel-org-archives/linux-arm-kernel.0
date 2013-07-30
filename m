From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 30 Jul 2013 10:44:57 +0100
Subject: [PATCH] ARM: Fix r7/r11 confusion when CONFIG_THUMB2_KERNEL=y [OT]
In-Reply-To: <20130730113853.46cbb00a@armhf>
References: <1373685501-1620-1-git-send-email-jld@mozilla.com>
 <20130715135420.GG10000@mudshark.cambridge.arm.com>
 <20130720044655.GC9433@mozilla.com>
 <20130721213753.GA29879@mudshark.cambridge.arm.com>
 <20130722185234.GA14519@localhost.localdomain>
 <20130729212140.GB12681@mozilla.com>
 <20130730092517.GB2478@localhost.localdomain>
 <20130730113853.46cbb00a@armhf>
Message-ID: <20130730094457.GC2478@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 11:38:53AM +0200, Jean-Francois Moine wrote:
> On Tue, 30 Jul 2013 10:25:18 +0100
> Dave Martin <Dave.Martin@arm.com> wrote:
> 
> > The pragmatic route is less contraversial and lower overhead: even though
> > it's not correct as per the ABI, GCC is the only supported compiler for
> > building the kernel anyway.
> 
> BTW, kernels compiled with gcc-4.8 don't work.

I haven't tried 4.8 yet.  Do you know what the problem is?

> Did anybody succeed with clang?

Hmm, I've no idea.  Is this possible?

Cheers
---Dave

> 
> -- 
> Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
> Jef		|		http://moinejf.free.fr/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
