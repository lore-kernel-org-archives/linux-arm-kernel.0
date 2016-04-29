From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 09:49:30 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160428092608.GE17159@lukather>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
 <20160428092608.GE17159@lukather>
Message-ID: <CACRpkdaFJV3OmEgUyyTPj5GCHvavaTiU2fz9S-2x36ivJ-W_RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 11:26 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Still, moving it to a "framework" that has been inactive for so long
> (and you even mention it in your PR) doesn't seem like the right move.

I still think sorting the driver into the right bucket has a value.

When/if the Linux LCD support gets an upstream push they
will know where to put their stuff: here, and then common stuff
can be abstracted. With drivers floating around in misc the
situation is even worse. http://lcd-linux.sourceforge.net/

Yours,
Linus Walleij
