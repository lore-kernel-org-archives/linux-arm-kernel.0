From: joe@perches.com (Joe Perches)
Date: Tue, 26 Feb 2013 17:40:34 -0800
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130226221027.GW17833@n2100.arm.linux.org.uk>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
Message-ID: <1361929234.1924.8.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-26 at 22:10 +0000, Russell King - ARM Linux wrote:
> So... for a selected kernel version of a particular size, can we please
> have a comparison between the new LZO code and this LZ4 code, so that
> we can see whether it's worth updating the LZO code or replacing the
> LZO code with LZ4?

How could it be questionable that it's worth updating the LZO code?
