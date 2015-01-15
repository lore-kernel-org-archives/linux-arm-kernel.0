From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Jan 2015 17:29:49 -0800
Subject: [PATCH] arm: mach-versatile: core: Remove unused function
In-Reply-To: <CACRpkdan1BZQnYgTdF9ctbLOPNoDwDX3Epy8Xfttd2v4-G-4Lw@mail.gmail.com>
References: <1420303959-12898-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <CACRpkdan1BZQnYgTdF9ctbLOPNoDwDX3Epy8Xfttd2v4-G-4Lw@mail.gmail.com>
Message-ID: <20150115012949.GF32756@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 12:53:07PM +0100, Linus Walleij wrote:
> On Sat, Jan 3, 2015 at 5:52 PM, Rickard Strandqvist
> <rickard_strandqvist@spectrumdigital.se> wrote:
> 
> > Remove the function versatile_leds_event() that is not used anywhere.
> >
> > This was partially found by using a static code analysis program called cppcheck.
> >
> > Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> That's right, the code was made redundant in
> commit e031cd513ec2ff661465dc1198220075719e72d1
> "ARM: mach-realview and mach-versatile: retire custom LED code"
> 
> ARM SoC folks: I suggest you apply this patch directly to your cleanup
> branch.

Thanks, applied with a minor tweak to the patch subject.


-Olof
