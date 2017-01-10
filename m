From: jintack@cs.columbia.edu (Jintack Lim)
Date: Tue, 10 Jan 2017 11:18:21 -0500
Subject: [RFC 00/55] Nested Virtualization on KVM/ARM
In-Reply-To: <7991b5fa-cbd3-a3b3-3f1c-8b8655ebdcfd@redhat.com>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <7991b5fa-cbd3-a3b3-3f1c-8b8655ebdcfd@redhat.com>
Message-ID: <CAHyh4xg23zgqzJa9yUgXdjZN5v45fBLjDFJok_DPSWUo9UaewQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 10:05 AM, David Hildenbrand <david@redhat.com> wrote:
>
>> Even though this work is not complete (see limitations below), I'd
>> appreciate
>> early feedback on this RFC. Specifically, I'm interested in:
>> - Is it better to have a kernel config or to make it configurable at
>> runtime?
>
>
> x86 and s390x have a kernel module parameter (nested) that can only be
> changed when loading the module and should default to false. So the
> admin explicitly has to enable it. Maybe going the same path makes
> sense.

I think that makes sense. Thanks!

>
> --
>
> David
>
