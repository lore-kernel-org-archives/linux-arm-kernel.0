From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Aug 2011 22:38:03 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <20110816113446.GA17310@n2100.arm.linux.org.uk>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
	<20110816092615.GC28656@e102144-lin.cambridge.arm.com>
	<CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
	<20110816095936.GE28656@e102144-lin.cambridge.arm.com>
	<20110816100906.GA16159@n2100.arm.linux.org.uk>
	<20110816101711.GF28656@e102144-lin.cambridge.arm.com>
	<20110816113446.GA17310@n2100.arm.linux.org.uk>
Message-ID: <20110816213802.GA24826@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, Aug 16, 2011 at 12:34:46PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 16, 2011 at 11:17:11AM +0100, Will Deacon wrote:
> > Yup, I agree about the usage of earlyprintk. It would be good if the user
> > could select the platform on which LL debug will work at config time and
> > then not have to worry about multiple conflicting definitions of
> > DEBUG_LL_UART_OFFSET. That way, you know on which platform earlyprintk
> > will work and don't try to use it on any others.
> 
> Feel free to send a patch to do that.

I've pulled something simple together, based on what you proposed earlier
on. I'll post it to the list shortly...

Will
