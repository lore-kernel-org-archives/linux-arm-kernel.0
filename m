From: bp@alien8.de (Borislav Petkov)
Date: Wed, 27 Feb 2013 17:53:20 +0100
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130227163118.GB17833@n2100.arm.linux.org.uk>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
 <20130227095609.GY17833@n2100.arm.linux.org.uk>
 <1361980152.2035.13.camel@joe-AO722>
 <20130227163118.GB17833@n2100.arm.linux.org.uk>
Message-ID: <20130227165320.GB2638@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 04:31:18PM +0000, Russell King - ARM Linux wrote:
> I'm not saying that the LZO code should not be updated. I'm saying
> that the kernel boot time decompressor is not a play ground for an
> ever increasing number of "my favourite compression method" crap.
> We don't need four, five or even six compression methods there. We
> just need three - a "fast but large", "small but slow" and "all round
> popular medium".

Hell yeah!

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
