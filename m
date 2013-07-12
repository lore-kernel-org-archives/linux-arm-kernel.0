From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Jul 2013 12:23:26 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130712101319.GA13421@gmail.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com> <20130712080145.GC24008@pd.tnic>
 <20130712101319.GA13421@gmail.com>
Message-ID: <20130712102326.GE24008@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 12:13:19PM +0200, Ingo Molnar wrote:
> and now it is upstream already, via -mm:
> 
>    e76e1fdfa8f8 lib: add support for LZ4-compressed kernel

Sure. Let's see if it manages to get released b0rked like it is right
now.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
