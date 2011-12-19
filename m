From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 21:28:47 +0000
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <201112192205.25806.marek.vasut@gmail.com>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <201112192154.25310.marek.vasut@gmail.com>
 <20111219210317.GI14542@n2100.arm.linux.org.uk>
 <201112192205.25806.marek.vasut@gmail.com>
Message-ID: <20111219212847.GK14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 10:05:25PM +0100, Marek Vasut wrote:
> > On Mon, Dec 19, 2011 at 09:54:25PM +0100, Marek Vasut wrote:
> > > > So, in summary, you have everything you require to fix it outside the
> > > > driver.  You just have to decide which of the two options you want to
> > > > proceed with, and actually (and finally) do it instead of endlessly
> > > > procrastinating and waiting for more and more bug reports (which is
> > > > exactly what has happened so far.)
> > > 
> > > What the hell, I just recently found this bug and I submitted a patch
> > > right away! What are you complaining about?!
> > 
> > If you want to take that attitude to my attempt to help you understand
> > the problem and see solutions, I'll ignore you permanently for being an
> > absolute twit.
> 
> Go ahead, but you accused me of procrastinating and waiting even if the first 
> thing I did when I saw the bug was start solving it. That's just insane!
> 
> > I'm not going to spend time giving a detailed explaination
> > about the background and options over something to only then have it
> > immediately shoved back in my face with such a response.
> 
> I consider my response to the last part of your email appropriate.

Sorry, it wasn't directed personally at you, but to the entire MXS
community.  The facts over this are:

1. This problem has been known about since October.
2. It's been discussed several times - every time along the same lines.
3. There is zero apparant progress on the issue.

Here's two of the discussions over it, where I've said exactly the same
thing:

http://lists.arm.linux.org.uk/lurker/thread/20111018.173744.46c4bd76.en.html
http://lists.arm.linux.org.uk/lurker/thread/20111123.183640.222b05cf.en.html

So now, tell me - is this _finally_ going to get fixed in the MXS code,
or is the previous discussion about converting stuff to spinlocks etc
just going to be repeated yet again?
