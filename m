From: keescook@chromium.org (Kees Cook)
Date: Thu, 15 Nov 2012 12:23:48 -0800
Subject: [PATCH v5 0/4] arch/arm: support seccomp
In-Reply-To: <20121115132550.GA5570@mudshark.cambridge.arm.com>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
 <CAGXu5jKYGCkL3GS4Tbep==WUAqP-c_0edAdgy0XQ84rJxZUU2Q@mail.gmail.com>
 <20121115132550.GA5570@mudshark.cambridge.arm.com>
Message-ID: <CAGXu5jL6og3xq_V=FkemV828Tso5F4wSoLy_24HA_LFw_x20Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 5:25 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Nov 14, 2012 at 07:07:13PM +0000, Kees Cook wrote:
>> Hi, any more thoughts on this series? I'd really like to get it into
>> -next. It's been running happily for a while now in the Chrome OS ARM
>> devices.
>
> I'm not familiar with seccomp in general, but the changes look ok now from
> an ARM point-of-view:
>
>   Reviewed-by: Will Deacon <will.deacon@arm.com>
>
> These should probably go via Russell (who will put them into -next), so
> please send them to the patch system.

Thanks. Is there a sensible way to send an ordered patch series to the
patch system? The Help doc says:
   Please omit [PATCH] and other "useful" prefixes.
(and it wants the "KernelVersion: " in there too)

Is there some way to indicate 1/4, 2/4, etc?

-Kees

-- 
Kees Cook
Chrome OS Security
