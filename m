From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 2 Jan 2014 15:15:47 -0800
Subject: [PATCH] Slightly outdated CONFIG_SMP documentation fix
In-Reply-To: <CAAJfVc7vK9W9Zy0LvGWSTWMSEb_JEx7FbLECy44QEwj+CWgSGg@mail.gmail.com>
References: <20131231225921.GA1624@sylph>
 <23596.1388674589@warthog.procyon.org.uk>
 <20140102150219.3df32a23cf7dbe9618ea118e@linux-foundation.org>
 <CAAJfVc7vK9W9Zy0LvGWSTWMSEb_JEx7FbLECy44QEwj+CWgSGg@mail.gmail.com>
Message-ID: <20140102151547.fde4aa5855cc75e91fea95e5@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jan 2014 23:08:43 +0000 Psychedelic Squid <psquid@psquid.net> wrote:

> On 2 Jan 2014 23:02, "Andrew Morton" <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 02 Jan 2014 14:56:29 +0000 David Howells <dhowells@redhat.com>
> wrote:
> >
> > > Robert Graffham <psquid@psquid.net> wrote:
> > >
> > > > +     singleprocessor machines. On a singleprocessor machine, the
> kernel
> > >
> > > "singleprocessor" looks wrong without a hyphen.  How about
> "uniprocessor"?
> > >
> >
> > Yes please.
> >
> > Also the patch should have a signed-off-by:, as per
> > Documentation/SubmittingPatches section 12, please.
> >
> 
> The signed-off-by: is already there.

ah, it was appended after the patch.  Don't do that ;)

> I'll get the other changes for the
> revised patch ready shortly, thanks. Also, newbie submitter and l couldn't
> find this in the documentation at a quick glance: should I submit it as a
> new thread, or a continuation of this?

Either is OK.  I tend to prefer continuation-of-this, mainly because it
prevents people from forgetting to cc people who were involved in
earlier discussion.

(Of course, if the discussion graph was complex, no reply-to-all will
capture all participants.  Nobody bothers to go through the discussion
gathering the names of all participants so I often end up doing this
when putting the final patch together)
