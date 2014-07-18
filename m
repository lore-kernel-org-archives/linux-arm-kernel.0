From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 18 Jul 2014 10:17:06 -0700
Subject: [PATCH v12 11/11] seccomp: add thread sync ability
In-Reply-To: <alpine.LRH.2.11.1407181325200.15709@namei.org>
References: <1405620518-18495-1-git-send-email-keescook@chromium.org>
 <alpine.LRH.2.11.1407181325200.15709@namei.org>
Message-ID: <CALCETrUv3G+C3PTOD1FJGOG8AQCA30hNkUiusCnQDGq6Kt_Feg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 8:26 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 17 Jul 2014, Kees Cook wrote:
>
>> Twelfth time's the charm! :)
>
> Btw, there doesn't seem to be an official seccomp maintainer.  Kees, would
> you like to volunteer for this?  If so, send in a patch for MAINTAINERS,
> and set up a git tree for me to pull from.

*snicker* :)

Kees, if you take on this awesome responsibility, should I send you a
rebased version of the fastpath stuff?  If so, I think that the
arch-neutral part should go in through your shiny new tree (once it's
reviewed to your satisfaction), and I'll ask hpa to pick up the x86
part.

I'd volunteer to be a "R:eviewer", but I don't think that the R tag
has made it into MAINTAINERS yet.

--Andy
