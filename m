From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2012 21:02:44 +0000
Subject: [PATCH v5 0/4] arch/arm: support seccomp
In-Reply-To: <CAGXu5jL6og3xq_V=FkemV828Tso5F4wSoLy_24HA_LFw_x20Zw@mail.gmail.com>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
 <CAGXu5jKYGCkL3GS4Tbep==WUAqP-c_0edAdgy0XQ84rJxZUU2Q@mail.gmail.com>
 <20121115132550.GA5570@mudshark.cambridge.arm.com>
 <CAGXu5jL6og3xq_V=FkemV828Tso5F4wSoLy_24HA_LFw_x20Zw@mail.gmail.com>
Message-ID: <20121115210244.GB13998@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 08:23:48PM +0000, Kees Cook wrote:
> On Thu, Nov 15, 2012 at 5:25 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Nov 14, 2012 at 07:07:13PM +0000, Kees Cook wrote:
> >> Hi, any more thoughts on this series? I'd really like to get it into
> >> -next. It's been running happily for a while now in the Chrome OS ARM
> >> devices.
> >
> > I'm not familiar with seccomp in general, but the changes look ok now from
> > an ARM point-of-view:
> >
> >   Reviewed-by: Will Deacon <will.deacon@arm.com>
> >
> > These should probably go via Russell (who will put them into -next), so
> > please send them to the patch system.
> 
> Thanks. Is there a sensible way to send an ordered patch series to the
> patch system? The Help doc says:
>    Please omit [PATCH] and other "useful" prefixes.
> (and it wants the "KernelVersion: " in there too)
> 
> Is there some way to indicate 1/4, 2/4, etc?

If you're using git send-email, you don't need to do anything other than
add a new tag below your S-o-B to indicate the kernel version, e.g:

  KernelVersion: 3.7-rc5

then send the patches (1 by 1 so they don't get re-ordered) to
patches at arm.linux.org.uk

You should receive a response indicating whether they were correctly
formatted or not.

Will
