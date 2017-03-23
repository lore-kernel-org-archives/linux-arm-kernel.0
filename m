From: thgarnie@google.com (Thomas Garnier)
Date: Thu, 23 Mar 2017 08:14:44 -0700
Subject: [PATCH v4 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <f0cf8766-4ee9-5386-5454-2301f429464c@zytor.com>
References: <20170322203834.67556-1-thgarnie@google.com>
 <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
 <CAJcbSZGLAXmE_mFZMAZgioWExzm3A4vXBKLGJ7DZNAbJOcH8Zw@mail.gmail.com>
 <f0cf8766-4ee9-5386-5454-2301f429464c@zytor.com>
Message-ID: <CAJcbSZEqeKVKbtUABzuhavxoH9KWCaVUBG3j5owAwyRhiw8Z7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay well then people are fine with a BUG_ON approach. I will do a
next iteration tailored to that. I will also try to add the static
inline suggestion from Peter.

On Wed, Mar 22, 2017 at 1:54 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 03/22/17 13:49, Thomas Garnier wrote:
>>
>> We can default to BUGging. I think my approach was avoiding doing a
>> BUG_ON just to avoid breaking people.
>>
>
> Breaking on a potentially-exploitable bug is a feature.
>
>         -hpa
>
>



-- 
Thomas
