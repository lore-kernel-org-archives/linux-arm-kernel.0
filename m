From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Feb 2013 09:56:09 +0000
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <1361929234.1924.8.camel@joe-AO722>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
Message-ID: <20130227095609.GY17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 05:40:34PM -0800, Joe Perches wrote:
> On Tue, 2013-02-26 at 22:10 +0000, Russell King - ARM Linux wrote:
> > So... for a selected kernel version of a particular size, can we please
> > have a comparison between the new LZO code and this LZ4 code, so that
> > we can see whether it's worth updating the LZO code or replacing the
> > LZO code with LZ4?
> 
> How could it be questionable that it's worth updating the LZO code?

Please read the comments against the previous posting of these patches
where I first stated this argument - and with agreement from those
following the thread.  The thread started on 26 Jan 2013.  Thanks.
