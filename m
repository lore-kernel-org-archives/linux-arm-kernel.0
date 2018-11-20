From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Tue, 20 Nov 2018 11:04:26 +0100
Subject: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
In-Reply-To: <20181120095751.GB17738@kroah.com>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
 <1128999886.40745.1542556549581@email.ionos.de>
 <20181120095751.GB17738@kroah.com>
Message-ID: <17a08397268fddb774ca0d1620d67ca38633a284.camel@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-11-20 at 10:57 +0100, Greg KH wrote:
> On Sun, Nov 18, 2018 at 04:55:49PM +0100, Stefan Wahren wrote:
> > Hi Nicolas,
> > 
> > > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 14.
> > > November 2018 um 13:59 geschrieben:
> > > 
> > > 
> > > Hi All,
> > > 
> > > This series was written in parallel with reading and
> > > understanding the
> > > vchiq code. So excuse me for the lack of logic in the sequence of
> > > patches.
> > > 
> > > The main focus was to delete as much code as possible, I've
> > > counted
> > > around 550 lines, which is not bad. Apart from that there are
> > > some
> > > patches enforcing proper kernel APIs usage.
> > > 
> > > The only patch that really changes code is the
> > > vchiq_ioc_copy_element_data() rewrite.
> > > 
> > > The last commit updates the TODO list with some of my
> > > observations, I
> > > realise some of the might be a little opinionated. If anything
> > > it's
> > > going to force a discussion on the topic, which is nice.
> > > 
> > > It was developed on top of the latest linux-next, and was tested
> > > on a
> > > RPIv3B+ with audio, video and running vchiq_test.
> > > 
> > > Regards,
> > > Nicolas
> > > 
> > 
> > without a changelog i won't start a review.
> 
> What do you mean by this?  The individual patches have a "changelog"
> in
> them, this is just a summary of the overall changes.
> 
> What do you feel is missing here?

Hi Greg,
I did send an RFC version of this, to which Stephan made several
comments. I should have added the changelog to the proper series
submission. I've been busy with work, but I'll send the updated version
during the day.

Regards,
Nicolas

> 
> thanks,
> 
> greg k-h

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/9c2d971a/attachment-0001.sig>
