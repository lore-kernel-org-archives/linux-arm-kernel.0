From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Nov 2015 10:01:46 -0800
Subject: [PATCH 00/10] ARM MTD AFS v2 partition support
In-Reply-To: <CACRpkdafrinB=EdjRT2coHbG9o==QGPHqe0YNOk99gnFRkP_bg@mail.gmail.com>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
 <20151111021549.GV12143@google.com>
 <CACRpkdafrinB=EdjRT2coHbG9o==QGPHqe0YNOk99gnFRkP_bg@mail.gmail.com>
Message-ID: <20151111180146.GB12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 04:13:19PM +0100, Linus Walleij wrote:
> On Wed, Nov 11, 2015 at 3:15 AM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> 
> > Also, do you have a pointer that documents the v2 format? I can probably
> > find something myself, but I'm a bit lazy, and if you have something
> > easy to point me to, that'd save me some time :)
> 
> There are no documents. The documentation is the source code for
> the on-board boot monitor (first thing started by the ROM) that
> comes with the board on a CD/DVD. A .h file documents the struct
> that is simply written to flash as footer and image info. I don't
> think I may post it, the structs in the kernel correspond to these
> structs.

Well, laziness paid off then; I probably wouldn't have been very
successful if I looked myself.

Thanks,
Brian
