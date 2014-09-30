From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 12:39:37 +0200
Subject: [PATCH v4 6/8] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <CAMo8Bf+u8er_KF4nJPSPNf9OmKZHu4y0x3Pcb7DU17y5ocBJqw@mail.gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
 <CAMo8BfJ9VJ24zsn_6VwNrAntmDqdJu11O79OyMd8eThv3UaaUw@mail.gmail.com>
 <CAMo8Bf+u8er_KF4nJPSPNf9OmKZHu4y0x3Pcb7DU17y5ocBJqw@mail.gmail.com>
Message-ID: <1799506.5Clfp6gmMu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 14:26:20 Max Filippov wrote:
> On Tue, Sep 30, 2014 at 2:22 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > Hi Thierry,
> >
> >> I think this can be fixed by including linux/string.h for memset() and
> >> memcpy() in include/asm-generic/io.h.
> >
> > Will you send that fix or do I need to do it?
> 
> Never mind, found that it's fixed in today's next.
> 
> 


Actually I just backed out the original patches, the problem is still
there in my tree.

	Arnd
