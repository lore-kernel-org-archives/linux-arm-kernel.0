From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 11 May 2016 10:34:18 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160511094635.299db364@erd979>
References: <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
 <20160428092608.GE17159@lukather> <5723755D.9060108@ti.com>
 <20160509090615.6272f8ca@erd979>
 <CACRpkdbZmL9Cqp-ubzyxd7fWUFOVsS1DCxsfG02kSpbWu_rbZQ@mail.gmail.com>
 <20160509161728.3aee1134@erd979>
 <CACRpkdZwPVMx-dXVkfVwFN0juzVuyvShV7yDWbUFSXOPE=uUrw@mail.gmail.com>
 <20160510071004.GA7318@kroah.com> <20160511094635.299db364@erd979>
Message-ID: <20160511083418.GB29268@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 09:46:35AM +0200, Robin van der Gracht wrote:
> On Tue, 10 May 2016 09:10:04 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, May 09, 2016 at 04:27:00PM +0200, Linus Walleij wrote:
> > > On Mon, May 9, 2016 at 4:17 PM, Robin van der Gracht
> > > <robin@protonic.nl> wrote:  
> > > > On Mon, 9 May 2016 15:19:26 +0200
> > > > Linus Walleij <linus.walleij@linaro.org> wrote:
> > > >  
> > > >> On Mon, May 9, 2016 at 9:06 AM, Robin van der Gracht
> > > >> <robin@protonic.nl> wrote:
> > > >>  
> > > >> > If you guys feel like auxdisplay is not the right subsystem
> > > >> > for the driver, and would like me to move it, please share.  
> > > >>
> > > >> The best would be if you volunteer to maintain it and bring
> > > >> it forward.  
> > > >
> > > > Thats fine. Would it suffice if I submit another patch adding
> > > > myself to the maintainers file?  
> > > 
> > > That's half of it, if Miguel does not come back then his name
> > > should be removed as the second step.
> > > 
> > > You also need to have an idea on a path to funnel accumulated
> > > patches upstream to Torvalds. The recent patches to this
> > > subsystem were funneled by Greg, so we should ask him how
> > > he prefer to proceed.
> > > 
> > > Greg, what do you prefer?  
> > 
> > I don't care :)
> > 
> > I can keep doing this, sending stuff to Linus through my char/misc
> > tree, or it can go through someone else's tree, it doesn't bother
> > me...
> 
> Soo.. You're allowing me to send patches to you so you can funnel
> them through your channel (for now)?

Sure, I'd be glad to do so if that makes your life easier.  Either way
it's no real extra or less overall workload for me :)

thanks,

greg k-h
