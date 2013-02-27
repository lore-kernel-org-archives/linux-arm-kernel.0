From: joe@perches.com (Joe Perches)
Date: Wed, 27 Feb 2013 07:49:12 -0800
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130227095609.GY17833@n2100.arm.linux.org.uk>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
 <20130227095609.GY17833@n2100.arm.linux.org.uk>
Message-ID: <1361980152.2035.13.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-02-27 at 09:56 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 26, 2013 at 05:40:34PM -0800, Joe Perches wrote:
> > On Tue, 2013-02-26 at 22:10 +0000, Russell King - ARM Linux wrote:
> > > So... for a selected kernel version of a particular size, can we please
> > > have a comparison between the new LZO code and this LZ4 code, so that
> > > we can see whether it's worth updating the LZO code or replacing the
> > > LZO code with LZ4?
> > 
> > How could it be questionable that it's worth updating the LZO code?
> 
> Please read the comments against the previous posting of these patches
> where I first stated this argument - and with agreement from those
> following the thread.  The thread started on 26 Jan 2013.  Thanks.

https://lkml.org/lkml/2013/1/29/145

I did not and do not see significant value in
adding LZ4 given Markus' LZO improvements.

I asked about LZO.

Why would the LZO code not be updated?

The new LZO code is faster than ever and it's
a standalone improvement.

Markus has posted what seems a clean git pull
request.  It was not cc'd to arm or linux-arch.

http://linux-kernel.2935.n7.nabble.com/GIT-PULL-Update-LZO-compression-code-for-v3-9-td605184.html
