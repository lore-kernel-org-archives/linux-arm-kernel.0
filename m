From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Jul 2013 10:01:46 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130712075602.GA4002@gmail.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com>
Message-ID: <20130712080145.GC24008@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 09:56:02AM +0200, Ingo Molnar wrote:
> If a utility is not widely available yet and if the utility is not in
> the kernel proper, could you please at least make sure that randconfig
> does not stumble over non-buildable kernels?

Two months ago I've complained about this and other people have burned
themselves too in the meantime...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
