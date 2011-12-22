From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Dec 2011 15:22:20 +0000
Subject: Adding remoteproc/rpmsg to linux-next
In-Reply-To: <CAK=WgbZm9txdvZ1VW-iUn5306yMz1Y=DT_Uygwi6zPZNyWx7gA@mail.gmail.com>
References: <CAK=WgbaU6vpiBGSgogYPjQNmrF-U0wk1rSXMX83DdgQa9hw5Mw@mail.gmail.com>
 <20111212103301.5ff6a582dca82394ace40e8d@canb.auug.org.au>
 <CAK=WgbZm9txdvZ1VW-iUn5306yMz1Y=DT_Uygwi6zPZNyWx7gA@mail.gmail.com>
Message-ID: <201112221522.21146.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 December 2011, Ohad Ben-Cohen wrote:
> Hi Arnd,
> 
> On Mon, Dec 12, 2011 at 1:33 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Fri, 9 Dec 2011 16:55:27 +0200 Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >>
> >> Can you please add the following remoteproc tree to linux-next ?
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git for-next
> >
> > I have added that from today.
> 
> Would you like rpmsg/remoteproc to go through arm-soc or do you prefer
> me to send a pull request directly to Linus ?
> 
> If you prefer the former (IIRC you told me you might consider it in a
> random ELCE hallway conversation :) then I'll send you a pull request.
> 
> I'm happy either way.

Either way works for me, too. Right now, I would tend to let you send it
to Linus directly because I haven't looked at the latest versions of the
code for some time. While I generally trust you to do the right thing
there, I'm not 100% comfortable to vouch for it in the way that an Ack
or pull would imply without doing a more detailed review of the latest
code.

I know that I promised you that review, but haven't gotten to it, sorry.
I've done a 5 minute review now and it absolutely looks good to go in
as far as I can tell, so I certainly don't object to you sending it
to Linus for 3.3. If you think you need more Acks or if there are other
reasons to have it go through arm-soc, please tell me and I'll try harder
to find the time for a proper review.

	Arnd
