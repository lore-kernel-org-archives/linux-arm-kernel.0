From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jul 2012 16:19:44 +0100
Subject: MX28 poweroff issue
In-Reply-To: <201207041631.30107.marex@denx.de>
References: <201207040030.36713.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
 <20120704093823.8e74d48bc8d9918a9c80fbcf@kinali.ch>
 <201207041631.30107.marex@denx.de>
Message-ID: <20120704151944.GB18739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 04:31:29PM +0200, Marek Vasut wrote:
> Dear Attila Kinali,
> 
> > On Wed, 4 Jul 2012 00:14:12 -0300
> > 
> > Fabio Estevam <festevam@gmail.com> wrote:
> > > On Tue, Jul 3, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:
> > > > Dunno, can you try on mx28 please?
> > > 
> > > I get the same crash as you reported.
> > > 
> > > On a mx27 (also ARM926EJS) I do not see this problem.
> > 
> > I have the same issue on the mx23 (using 3.5-rc5):
> 
> Thank you, all of you who tested it on random devices and pointed out stuff :-)
> 
> Shawn, do you have any suggestions on how to proceed? Shall we use Russells 
> approach?

If it's specific to mx28 and mx23 and nothing else, the cause needs to
be found.  Maybe we need it tested on other (non-MX) platforms too?
