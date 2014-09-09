From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Sep 2014 12:40:51 +0100
Subject: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain
 look-up
In-Reply-To: <8273189.CFBBe805uk@vostro.rjw.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <3105400.7vSnq2rA6s@vostro.rjw.lan>
 <CAMuHMdURbp8a0Ps2sZUZn7UHcWXZvRgS-4ubk1r=wGgXZ1PHmA@mail.gmail.com>
 <8273189.CFBBe805uk@vostro.rjw.lan>
Message-ID: <20140909114051.GT2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 11:26:49PM +0200, Rafael J. Wysocki wrote:

> The s-o-b is more of a gray area, but again it is supposed to be possible
> to verify which it won't be if it bounces.

That's always going to be an issue with signoffs - people's addresses
can and do go bad at any point.

> Also note that this is not Tomasz who is submitting this patch today, but Ulf
> who doesn't even work for Samsung as far as I know.

> So I'd suggest using "Tomasz Figa <tomasz.figa@gmail.com>" as a "From:", remove
> his s-o-b entirely (and using the Ulf's one only) and add something like that
> to the changelog:

> "This patch was originally submitted by Tomasz Figa when he was employed
>  by Samsung.

>  Link: <URL-of-the-original-submission>"

> This way Samsung will get the recognition and there won't be bouncing addresses
> in tags etc.

Stripping people's signoffs seems more worrying than a bouncing address
TBH - it's more alarming to see a commit log that's missing an author
signoff than finding an address that doesn't work, I'd probably just
drop any submissions that did that.  If you're really worried updating
the signoff address or adding a comment with the new one is probably
better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/55ad43ef/attachment-0001.sig>
