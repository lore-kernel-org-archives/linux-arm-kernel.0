From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 2 Jan 2014 16:50:50 -0800
Subject: [PATCH 1/2] seqlock: Use raw_ prefix instead of _no_lockdep
In-Reply-To: <1388704274-5278-1-git-send-email-john.stultz@linaro.org>
References: <52C5E675.80701@linaro.org>
 <1388704274-5278-1-git-send-email-john.stultz@linaro.org>
Message-ID: <CA+55aFxv8wTRifZ9iHn-tCfUqwpJZmLiF7QU=Pc6dVa8QnTyCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 3:11 PM, John Stultz <john.stultz@linaro.org> wrote:
> Linus disliked the _no_lockdep() naming, so instead
> use the more-consistent raw_* prefix to the non-lockdep
> enabled seqcount methods.
>
> This also adds raw_ methods for the write operations
> as well, which will be utilized in a following patch.

Ack on this and on 2/2. I'm assuming I'll get them through the -tip
tree, which is where the problem came from. No?

               Linus
