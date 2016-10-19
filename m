From: markus@trippelsdorf.de (Markus Trippelsdorf)
Date: Wed, 19 Oct 2016 17:56:58 +0200
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
Message-ID: <20161019155658.GB4411@x4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016.10.19 at 08:55 -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2016 at 8:37 AM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
> >
> > This is a gcc bug, see:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=72785
> 
> Well, in the meantime we apparently have to live with it. Unless Will
> is using some unreleased gcc version that nobody else is using and we
> can just ignore it?

Yes, he is using gcc-7 that is unreleased. (It will be released April
next year.) 

-- 
Markus
