From: lee@kernel.org (Lee Jones)
Date: Wed, 28 Oct 2015 09:45:38 +0000
Subject: [PATCH soc/next] ARM: bcm2835: add mutual inclusion protection
In-Reply-To: <20151027174230.GA9495@omega>
References: <1445539565-24955-1-git-send-email-alex.aring@gmail.com>
 <20151027170003.GB5828@x1> <20151027174230.GA9495@omega>
Message-ID: <20151028094538.GO5828@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2015, Alexander Aring wrote:
> On Tue, Oct 27, 2015 at 05:00:03PM +0000, Lee Jones wrote:
> > On Thu, 22 Oct 2015, Alexander Aring wrote:
> > 
> > > This patch adds mutual inclusion protection for the rpi firmware header.
> > > 
> > > Cc: Eric Anholt <eric@anholt.net>
> > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > 
> > Looks like these didn't work.  You might want to look into that.
> > 
> > You either have --no-signed-off-by-cc set, or you're not using `git
> > send-email`.
> > 
> 
> I am using git send-email without "--no-signed-off-by-cc".
> 
> > From the man page:
> > 
> > --[no-]signed-off-by-cc
> >     If this is set, add emails found in Signed-off-by: or Cc: lines to
> >     the cc list. Default is the value of sendemail.signedoffbycc
> >     configuration value; if that is unspecified, default to
> >     --signed-off-by-cc.
> > 
> 
> I wonder if this is really not working.
> 
> Stephen Warren, Eric Anholt did you receive my mail? I saw everybody
> (except you) has these two in cc when they replied.

That would be very peculiar.

Here's the header of the mail I received from you:

Date: Thu, 22 Oct 2015 20:46:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: f.fainelli at gmail.com
Cc: linux-rpi-kernel at lists.infradead.org, linux-arm-kernel at lists.infradead.org
Subject: [PATCH soc/next] ARM: bcm2835: add mutual inclusion protection

No sign of Eric or Stephen.
