From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2012 13:55:44 +0100
Subject: [PATCH v7 3/3] MTD: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1337255011.2564.2.camel@koala>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
 <1337160353.24809.26.camel@sauron.fi.intel.com>
 <20403.29677.517067.528042@ipc1.ka-ro>
 <1337161217.24809.38.camel@sauron.fi.intel.com> <4FB49C60.5030002@atmel.com>
 <1337255011.2564.2.camel@koala>
Message-ID: <20120517125544.GJ9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 02:43:31PM +0300, Artem Bityutskiy wrote:
> On Thu, 2012-05-17 at 14:36 +0800, Josh Wu wrote:
> > >> message text should not be split across lines anyway to ease grepping
> > >> for the message.
> > > I think the consensus is that it is personal decision of the author. I
> > > am not trying to enforce this and I also split messages. In this case I
> > > was only wondering why that backslash is used? I never saw this before
> > > in the linux kernel.
> > >
> > 
> > oh, I add the backslash only because if without it, there should be a 
> > warning about message is splitting into two lines.
> 
> Backslash is not needed in C. The preprocessor removes it anyway. We do
> not put them.
> 
> > Now I think I will just keep the text message in one line. That will 
> > avoid any warnings. thanks.
> 
> You can just remove the backslashes. I think your lines splitting is
> fine otherwise.

It's also preferred _not_ to wrap error messages as that makes them
harder to grep for.  Linus has mentioned this several times on LKML
and has corrected error messages that he encounters that he can't
find via grep.
