From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:11:52 +0000
Subject: [PATCH] mach-ixp4xx: made gpio functions atomic
In-Reply-To: <CACW_hTYn1_9fDCve2gg0Wr-DkNqWfaEQXTtT+ooFsBBo9ksivw@mail.gmail.com>
References: <1319973693-19063-1-git-send-email-fransmeulenbroeks@gmail.com>
 <CACW_hTYn1_9fDCve2gg0Wr-DkNqWfaEQXTtT+ooFsBBo9ksivw@mail.gmail.com>
Message-ID: <20120103091152.GE2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 04:45:21PM +0100, Frans Meulenbroeks wrote:
> Ping.
> 
> Didn't hear anything concerning this patch I submitted 2 months ago.
> Seems a very trivial patch to me. Would it be possible to apply this (or
> provide feedback why it is not ok).

This should really be using the gpiolib stuff rather than persisting with
its own private gpio API invention (and fixing problems in it which
gpiolib already solves.)

Any chance someone could look into doing that conversion?
