From: bp@alien8.de (Borislav Petkov)
Date: Fri, 29 May 2015 23:41:35 +0200
Subject: [PATCH] EDAC, edac_stub: Drop arch-specific include
In-Reply-To: <CAPw-ZTnqfCLY_e91OLmbaaPMn9O9DLo1GXoA+0LZTusF01kM2g@mail.gmail.com>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <20150529094654.GD31435@pd.tnic>
 <CAPw-ZTnLqx0KsQkmv++zQRQ7hroaKML1rWgVafisENam0J17Mg@mail.gmail.com>
 <20150529185926.GP31435@pd.tnic> <20150529200520.GT31435@pd.tnic>
 <CAPw-ZTnqfCLY_e91OLmbaaPMn9O9DLo1GXoA+0LZTusF01kM2g@mail.gmail.com>
Message-ID: <20150529214135.GV31435@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 02:25:52PM -0700, Loc Ho wrote:
> On Fri, May 29, 2015 at 1:05 PM, Borislav Petkov <bp@alien8.de> wrote:
> > On Fri, May 29, 2015 at 08:59:26PM +0200, Borislav Petkov wrote:
> >> Does it build when you remove it?
> >
> > IOW, this should fix it:
> 
> Confirmed.

Thanks, I'll queue it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
