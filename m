From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 20 Apr 2011 13:37:04 -0500
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <143ea9b1bb96e613d534caa7cb3a1e2d.squirrel@www.codeaurora.org>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
	<BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
	<BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
	<143ea9b1bb96e613d534caa7cb3a1e2d.squirrel@www.codeaurora.org>
Message-ID: <BANLkTi=Zxt96b50DiuE_KVf2dv_vJooFnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, Apr 20, 2011 at 1:01 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> It's here:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6885/1
>
> I imagine it will be added when/if Russell picks it up. Sadly it
> increases the LOC in ARM so Simon might need to really
> sell it to get it merged.

I guess saying that it indirectly fixes wrong code generation on some
cases[1] might give an extra push.

Regards,

Omar

---
[1] http://lkml.org/lkml/2011/3/31/490
