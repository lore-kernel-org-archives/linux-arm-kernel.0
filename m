From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 26 Oct 2010 15:50:51 +0300
Subject: Is ep93xx support broken in linux-next?
In-Reply-To: <1288094199.2098.26.camel@r60e>
References: <1288094199.2098.26.camel@r60e>
Message-ID: <20101026125050.GB15333@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Tue, Oct 26, 2010 at 03:56:39PM +0400, Alexander Sverdlin wrote:
> 2.6.36-rc4, -rc7, 2.6.36 are working fine
> linux-next git tree from Oct 25 produced kernel panic (kill init)
> linux-next from Oct 26 cannot parse RedBoot partitions...
> 
> Does anybody have luck with recent git images on Cirrus boards?

I've just updated my git tree to the latest mainline and indeed it
fails to boot with ep9307. I investigated this further and managed
to get it working with the attached patch. Can you try it and verify
whether it fixes your problem?

Thanks,
MW
