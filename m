From: alex.aring@gmail.com (Alexander Aring)
Date: Tue, 27 Oct 2015 18:42:35 +0100
Subject: [PATCH soc/next] ARM: bcm2835: add mutual inclusion protection
In-Reply-To: <20151027170003.GB5828@x1>
References: <1445539565-24955-1-git-send-email-alex.aring@gmail.com>
 <20151027170003.GB5828@x1>
Message-ID: <20151027174230.GA9495@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 27, 2015 at 05:00:03PM +0000, Lee Jones wrote:
> On Thu, 22 Oct 2015, Alexander Aring wrote:
> 
> > This patch adds mutual inclusion protection for the rpi firmware header.
> > 
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> 
> Looks like these didn't work.  You might want to look into that.
> 
> You either have --no-signed-off-by-cc set, or you're not using `git
> send-email`.
> 

I am using git send-email without "--no-signed-off-by-cc".

> From the man page:
> 
> --[no-]signed-off-by-cc
>     If this is set, add emails found in Signed-off-by: or Cc: lines to
>     the cc list. Default is the value of sendemail.signedoffbycc
>     configuration value; if that is unspecified, default to
>     --signed-off-by-cc.
> 

I wonder if this is really not working.

Stephen Warren, Eric Anholt did you receive my mail? I saw everybody
(except you) has these two in cc when they replied.

- Alex
