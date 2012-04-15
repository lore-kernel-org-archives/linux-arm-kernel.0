From: richard.weinberger@gmail.com (richard -rw- weinberger)
Date: Sun, 15 Apr 2012 12:38:36 +0200
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
Message-ID: <CAFLxGvwJCMoiXFn3OgwiX+B50FTzGZmo6eG3xQ1KaPsEVZVA1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2012 at 11:47 AM, PINTU KUMAR <pintu_agarwal@yahoo.com> wrote:
> Please provide your valuable feedback and suggestion.

This is fundamentally flawed.
You're assuming that only one program will use this interface.
Linux is a multi/user-tasking system

If we expose it to user space *every* program/user will try too free
memory such that it
can use more.
Can you see the problem?

-- 
Thanks,
//richard
