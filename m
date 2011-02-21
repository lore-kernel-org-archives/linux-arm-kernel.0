From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 21 Feb 2011 17:33:48 +0100
Subject: mc13xxx-core, support for i2c, V4
In-Reply-To: <201102122111.30525.marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<20110212084035.GB17755@angua.secretlab.ca>
	<201102122111.30525.marc@cpdesign.com.au>
Message-ID: <20110221163347.GG10686@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Sat, Feb 12, 2011 at 09:11:30PM +1100, Marc Reilly wrote:
> Hi Grant, 
> 
> Thanks for your comments,
> 
> On Saturday, February 12, 2011 07:40:35 pm Grant Likely wrote:
> > On Tue, Jan 04, 2011 at 04:34:55PM +1100, Marc Reilly wrote:
> > > Hi,
> > > 
> > > These patches add i2c support for the mc13xxx-core drive. For v4 I've
> > > tried to take in all previous comments, hopefully making it better to
> > > follow, and bisectable.
> > 
> > This series looks okay to me.  Since this is audio drivers, I expect
> > that it would best be taken via the ASoC tree?  Have you sent it to
> > Mark Brown and the ALSA list for review?
> > 
> > g.
> 
> Actually only the mc13873 has audio support. I think these IC's really fit 
> better under the MFD tree, but silly me didn't add Samuel Ortiz (MFD 
> maintainer) to this series... so included him now.
> 
> Samuel, are you the most appropriate to take this series in and would you like 
> me to resend these patches to you? The thread archive is at [1]. 
Yes, I would be the one taking those patches. Please resend the patch set to
me, and I'll have a look. Has Uwe commented on them yet ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
