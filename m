From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Jan 2013 15:04:10 +0000
Subject: [PATCH 2/2] gpio: pca953x: use managed resources
In-Reply-To: <CACRpkdaEH+hqOo6i+4Lz+T4B+oAvCj+v0Ycr576yV2fWN2VNvg@mail.gmail.com>
References: <1359133168-14879-1-git-send-email-gregory.clement@free-electrons.com>
 <1359133168-14879-3-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkdaEH+hqOo6i+4Lz+T4B+oAvCj+v0Ycr576yV2fWN2VNvg@mail.gmail.com>
Message-ID: <20130128150410.GM23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 11:17:48AM +0100, Linus Walleij wrote:
> On Fri, Jan 25, 2013 at 5:59 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
> 
> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > Using the devm_* managed resources the pca driver can be simplified
> > and cut down on boilerplate code.
> >
> > [gcl: fixed a inccorect reference to a removed label, "goto fail_out"
> > became "return ret"]
> 
> Oh now "gcl" means both Grant C. Likely and Gregory CLement :-)

I'd say gcl means Grant C. Likely.  gc would be Gregory Clement.
Initials. :)  Using anything else results in yet more many namespace
clashes.

Maybe we should switch to a numeric namespace instead? :)
