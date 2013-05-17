From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 19:05:55 +0100
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517180028.GK18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
 <20130517194023.0c385ea0@armhf>
 <20130517180028.GK18614@n2100.arm.linux.org.uk>
Message-ID: <20130517180555.GL18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 07:00:29PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 17, 2013 at 07:40:23PM +0200, Jean-Francois Moine wrote:
> > Maybe I did not explain correctly: the colored cursor maybe RGB888 +
> > transparency (64x64) or full ARGB (64x32 or 32x64). I coded the first
> > case. And, yes, I better like a hardware cursor: it asks for less
> > computation, and I get it immediately at graphic starting time!
> 
> Interesting.  Where did you find the documentation for the transparency?
> The FS lists HWC32_TRANS_CNTL but omits to specify where that gets used.

Ignore that, I just found the reference (unfortunately wrapped so evince
couldn't find it with a search.)
