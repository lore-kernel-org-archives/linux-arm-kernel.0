From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 17:57:24 +0100
Subject: [PATCH 4/9] ARM: vexpress: Initial common clock support
In-Reply-To: <CACRpkdZGVgO-1jnfK=fpo73ryLDe05R0_hghwBxzDfbBK9jBRA@mail.gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-5-git-send-email-pawel.moll@arm.com>
 <CACRpkdZGVgO-1jnfK=fpo73ryLDe05R0_hghwBxzDfbBK9jBRA@mail.gmail.com>
Message-ID: <1342025844.25865.3.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-11 at 17:51 +0100, Linus Walleij wrote:
> Hi Pawel,
> 
> can you please move the vexpress clock implementation to
> drivers/clk/versatile/clk-vexpress.c as per the pattern from the
> Integrator rework?
>
> Clock drivers go into the drivers/* hierarchy just like any other
> driver these days.

I will, but I'd rather avoid doing this right now.

> >This is a simple conversion of the existing state and will be
> > extended (and migrated to drivers/clk) in the near future.
> 
This patch is only a first step. I'm working now on a major rework of
the VE control infrastructure, and I do have drivers/clk/vexpress (can
be versatile, I don't really mind) directory in my local repo. This will
happen in time for the next merge window.

Cheers!

Pawel
