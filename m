From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 16:38:20 -0700
Subject: [PATCH 2/5] staging/vchi: Fix build warnings when formatting
 pointers on aarch64.
In-Reply-To: <20161017202834.GA30101@kroah.com>
References: <20161017194406.1080-1-eric@anholt.net>
 <20161017194406.1080-3-eric@anholt.net> <20161017202834.GA30101@kroah.com>
Message-ID: <87d1iyr1g3.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Oct 17, 2016 at 12:44:03PM -0700, Eric Anholt wrote:
>> The code was generally using "%x" to print and "(unsigned int)" to
>> cast the pointers, but we have %p for printing pointers in the same
>> format without any broken casts.
>
> I already did this work, it's all checked into my tree, and is in
> linux-next now.  You were cc:ed on the patches as well.

I actually haven't seen any of those messages about the patches.  It
looks like it's actually that notmuch is still failing to parse some
mails (they apparently disagree with postfix on how maildir files should
be formatted, so they just drop some mail on the floor).

I did check the staging-testing branch before I started, since that's
where things were last I knew, and didn't know it had moved to -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161017/c79885f6/attachment.sig>
