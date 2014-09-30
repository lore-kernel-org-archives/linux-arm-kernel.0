From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 30 Sep 2014 12:51:19 +0200
Subject: [PATCH v4 6/8] asm-generic/io.h: Implement generic
 {read,write}s*()
In-Reply-To: <1799506.5Clfp6gmMu@wuerfel>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
 <CAMo8BfJ9VJ24zsn_6VwNrAntmDqdJu11O79OyMd8eThv3UaaUw@mail.gmail.com>
 <CAMo8Bf+u8er_KF4nJPSPNf9OmKZHu4y0x3Pcb7DU17y5ocBJqw@mail.gmail.com>
 <1799506.5Clfp6gmMu@wuerfel>
Message-ID: <20140930105118.GA27560@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 12:39:37PM +0200, Arnd Bergmann wrote:
> On Tuesday 30 September 2014 14:26:20 Max Filippov wrote:
> > On Tue, Sep 30, 2014 at 2:22 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > Hi Thierry,
> > >
> > >> I think this can be fixed by including linux/string.h for memset() and
> > >> memcpy() in include/asm-generic/io.h.
> > >
> > > Will you send that fix or do I need to do it?
> > 
> > Never mind, found that it's fixed in today's next.
> > 
> > 
> 
> 
> Actually I just backed out the original patches, the problem is still
> there in my tree.

I'll integrate the fix for this in my series, so this should be gone
with v5.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/bbc88ae8/attachment.sig>
