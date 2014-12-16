From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 16 Dec 2014 14:04:42 +0100 (CET)
Subject: [PATCH v2 1/3] irqchip: vf610-mscm: add support for MSCM interrupt
 router
In-Reply-To: <5490094D.6090300@arm.com>
References: <1418594998-2361-1-git-send-email-stefan@agner.ch>
 <1418594998-2361-2-git-send-email-stefan@agner.ch> <548EB0FD.3030206@arm.com>
 <41a603b345dbee4f2507e80ea0f8bb96@agner.ch> <5490094D.6090300@arm.com>
Message-ID: <alpine.DEB.2.11.1412161404010.17382@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Dec 2014, Marc Zyngier wrote:
> On 15/12/14 20:58, Stefan Agner wrote:
> > The same line adjustment will break the 80 character border... But I
> > agree, it's ugly the way it is now. Will put them in the same line.
> 
> Never mind what checkpatch says. Readability trumps it anytime.

If you want to obey checkpatch then move that stuff into a seperate
inline function.

Thanks,

	tglx
