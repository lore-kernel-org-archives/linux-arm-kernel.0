From: jcmvbkbc@gmail.com (Max Filippov)
Date: Tue, 30 Sep 2014 14:26:20 +0400
Subject: [PATCH v4 6/8] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <CAMo8BfJ9VJ24zsn_6VwNrAntmDqdJu11O79OyMd8eThv3UaaUw@mail.gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
 <1407925738-26170-7-git-send-email-thierry.reding@gmail.com>
 <CAMuHMdW4emoma3nRUGna985tE17yPh5pNjMb-jxe5yc5UVr=cw@mail.gmail.com>
 <20140929085908.GI12506@ulmo>
 <CAMo8BfJ9VJ24zsn_6VwNrAntmDqdJu11O79OyMd8eThv3UaaUw@mail.gmail.com>
Message-ID: <CAMo8Bf+u8er_KF4nJPSPNf9OmKZHu4y0x3Pcb7DU17y5ocBJqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 2:22 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Thierry,
>
>> I think this can be fixed by including linux/string.h for memset() and
>> memcpy() in include/asm-generic/io.h.
>
> Will you send that fix or do I need to do it?

Never mind, found that it's fixed in today's next.

-- 
Thanks.
-- Max
