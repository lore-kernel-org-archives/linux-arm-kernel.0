From: john.stultz@linaro.org (John Stultz)
Date: Fri, 03 Jan 2014 16:28:31 -0800
Subject: [PATCH 1/2] seqlock: Use raw_ prefix instead of _no_lockdep
In-Reply-To: <CA+55aFxv8wTRifZ9iHn-tCfUqwpJZmLiF7QU=Pc6dVa8QnTyCQ@mail.gmail.com>
References: <52C5E675.80701@linaro.org>	<1388704274-5278-1-git-send-email-john.stultz@linaro.org>
 <CA+55aFxv8wTRifZ9iHn-tCfUqwpJZmLiF7QU=Pc6dVa8QnTyCQ@mail.gmail.com>
Message-ID: <52C755AF.5030402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2014 04:50 PM, Linus Torvalds wrote:
> On Thu, Jan 2, 2014 at 3:11 PM, John Stultz <john.stultz@linaro.org> wrote:
>> Linus disliked the _no_lockdep() naming, so instead
>> use the more-consistent raw_* prefix to the non-lockdep
>> enabled seqcount methods.
>>
>> This also adds raw_ methods for the write operations
>> as well, which will be utilized in a following patch.
> Ack on this and on 2/2. I'm assuming I'll get them through the -tip
> tree, which is where the problem came from. No?

It seems Peter or Ingo are still on holiday. Hopefully they will be back
on Monday to queue these.

thanks
-john
