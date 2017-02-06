From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 6 Feb 2017 10:33:38 -0700
Subject: [PATCH] somedriver: remove the initialization of static pointers.
In-Reply-To: <20170205081226.3c3c681e@GL552JX>
References: <1486237182-4563-1-git-send-email-abdallah.meziti.pro@gmail.com>
 <20170205002943.GA21184@kroah.com>
 <20170205081226.3c3c681e@GL552JX>
Message-ID: <20170206173338.GD11391@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 05, 2017 at 08:12:26AM +0100, AbdAllah MEZITI wrote:
> On Sun, 5 Feb 2017 01:29:43 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Feb 04, 2017 at 08:39:21PM +0100, AbdAllah-MEZITI wrote:
> > > In C a static pointer will be initialized to NULL (e.g: draft C99
> > > standard $6.7.8): "If an object that has static storage duration is
> > > not initialized explicitly, then:
> > >  __ if it has pointer type, it is initialized to a null pointer;"
> > > 
> > > Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>  
> > 
> > Your subject is very odd :(
> > 
> > And is that the correct spelling of your name that you use for legal
> > documents?  If not, please fix up when you resend this.
> > 
> > Also, fix the line-wrapping of your changelog, and the C99 standard is
> > not a "draft" anymore, it was released in 1999 :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Do not worry, this is just an answer to the Task 10 of the Eudyptula Challenge.

AbdAllah, 

Patches submitted as part of the Eudyptula Challenge are fixing real problems
and most of the time accepted for queueing.  As such the work you sumbit for it
is serious and should be as perfect as possible.

Happy times with the Challenge,
Mathieu

> 
> yes, this is the correct spelling of my name that i use for legal documents.
> 
> OK.
> 
> AbdAllah MEZITI.
