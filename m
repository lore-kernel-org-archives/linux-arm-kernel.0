From: bp@alien8.de (Borislav Petkov)
Date: Thu, 23 Mar 2017 16:32:04 +0100
Subject: [PATCH v4 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <CAJcbSZEqeKVKbtUABzuhavxoH9KWCaVUBG3j5owAwyRhiw8Z7g@mail.gmail.com>
References: <20170322203834.67556-1-thgarnie@google.com>
 <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
 <CAJcbSZGLAXmE_mFZMAZgioWExzm3A4vXBKLGJ7DZNAbJOcH8Zw@mail.gmail.com>
 <f0cf8766-4ee9-5386-5454-2301f429464c@zytor.com>
 <CAJcbSZEqeKVKbtUABzuhavxoH9KWCaVUBG3j5owAwyRhiw8Z7g@mail.gmail.com>
Message-ID: <20170323153204.4lxglq6jlvvxp6ev@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 08:14:44AM -0700, Thomas Garnier wrote:
> Okay well then people are fine with a BUG_ON approach. I will do a
> next iteration tailored to that. I will also try to add the static
> inline suggestion from Peter.

Would it be possible, please, to refrain from top-posting when replying
on the ML?

You sometimes reply inline and after the text and sometimes at the top.
This subthread has both variants and it is really annoying to people
like me who try to follow the discussion.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
