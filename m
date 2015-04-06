From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Apr 2015 09:54:43 +0100
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <8737db3eea65563054df98c932870590@agner.ch>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
 <20150403200931.GD13898@n2100.arm.linux.org.uk>
 <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
 <20150405161014.GG13898@n2100.arm.linux.org.uk>
 <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
 <20150405224455.GB12732@n2100.arm.linux.org.uk>
 <58bb3fd4f9e9b3acc7f8b83bd6664177@agner.ch>
 <20150406081523.GC12732@n2100.arm.linux.org.uk>
 <8737db3eea65563054df98c932870590@agner.ch>
Message-ID: <20150406085443.GD12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 10:38:10AM +0200, Stefan Agner wrote:
> We already prevent a kernel image which mixes V4/V4T/V5 and V6/V7. And
> so we would do with V7M too. Just because it's in multiplatform doesn't
> mean we need to mix things up.

I don't think you're getting what I'm saying at all... :(

Please read the first bit of my replies again, where I say that we do
_not_ want to remove the !MMU dependency from multiplatform.  This is
something I feel _very_ strongly about, and something which I've written
about many times on this list.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
