From: bp@alien8.de (Borislav Petkov)
Date: Wed, 26 Jun 2013 16:15:28 +0200
Subject: [PATCH 3/4] arm: Add [U]EFI runtime services support
In-Reply-To: <20130626135417.GP22026@console-pimps.org>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-4-git-send-email-leif.lindholm@linaro.org>
 <CACxGe6sH4dAVryBp7TeUmrwsJmnMdLsQm++U4EVDJVNi9pnqYw@mail.gmail.com>
 <20130626135417.GP22026@console-pimps.org>
Message-ID: <20130626141528.GF20274@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 02:54:17PM +0100, Matt Fleming wrote:
> On Wed, 26 Jun, at 02:46:09PM, Grant Likely wrote:
> > Eventually we'll need to look at how this interacts with kexec. A
> > kexec'd kernel will need to use the mapping already chosen by a
> > previous kernel, but that's an issue for another patch series.
> 
> FYI, this is exactly what Borislav has been tackling on x86 recently. It
> would be nice if we could find one scheme that suits everyone.

Is this arm 32 or 64-bit? Because we haven't talked about 32-bit on x86
either. From skimming over the code, I'm not sure the same top-down
allocation and 1:1 mapping would work there. But I haven't looked hard
yet so I dunno.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
