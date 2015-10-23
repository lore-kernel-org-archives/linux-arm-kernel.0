From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 23 Oct 2015 18:41:32 +0900 (JST)
Subject: [GIT PULL] ARM: SoC fixes for 4.3-rc
In-Reply-To: <6788509.osko4XNn1O@wuerfel>
References: <6788509.osko4XNn1O@wuerfel>
Message-ID: <alpine.LFD.2.20.1510231834520.24002@vaio.linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 22 Oct 2015, Arnd Bergmann wrote:
> 
> are available in the git repository at:
> 
>   git+ssh://gitolite at ra.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

What the heck happened to your pull request script? A sudden case of 
script disease?

That's just insane. "git+ssh"? "gitolite at ra.kernel.org"? Yeah, yeah, it 
probably works for people with accounts, but please don't use those 
private secure things in pull requests, particularly ones that go to 
public mailing lists.

And "git+ssh" may be a valid way to specify a git tree, but if you really 
want to just use ssh (which you don't), just use "ssh://", or use the 
shorter scp format ("host:path"). At least then it would be closer to fit 
on a line, and less of the line noise..

Anyway, I've pulled using the sane externally visible verion, so no need 
to resend, but check your scripting..

            Linus
