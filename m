From: bp@alien8.de (Borislav Petkov)
Date: Tue, 16 Jul 2013 11:59:38 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <201307161145.27810.yann.morin.1998@free.fr>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <201307161132.39845.yann.morin.1998@free.fr>
 <20130716093820.GE4402@pd.tnic>
 <201307161145.27810.yann.morin.1998@free.fr>
Message-ID: <20130716095938.GA4962@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:45:27AM +0200, Yann E. MORIN wrote:
> As discussed with Florian in this thread, either one of:
>   - a warning at check time
>   - a comment in Kconfig

Whatever you do, make sure to make it quite clear to users what she
needs to do.

What I really have a problem with is options being hidden just because I
haven't selected something they depend on and having to run around the
Kconfig maze to find what I also need to select in order for the option
to appear.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
