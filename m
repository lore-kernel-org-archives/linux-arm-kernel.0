From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2012 13:25:50 +0000
Subject: [PATCH v5 0/4] arch/arm: support seccomp
In-Reply-To: <CAGXu5jKYGCkL3GS4Tbep==WUAqP-c_0edAdgy0XQ84rJxZUU2Q@mail.gmail.com>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
 <CAGXu5jKYGCkL3GS4Tbep==WUAqP-c_0edAdgy0XQ84rJxZUU2Q@mail.gmail.com>
Message-ID: <20121115132550.GA5570@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 07:07:13PM +0000, Kees Cook wrote:
> Hi, any more thoughts on this series? I'd really like to get it into
> -next. It's been running happily for a while now in the Chrome OS ARM
> devices.

I'm not familiar with seccomp in general, but the changes look ok now from
an ARM point-of-view:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

These should probably go via Russell (who will put them into -next), so
please send them to the patch system.

Will
