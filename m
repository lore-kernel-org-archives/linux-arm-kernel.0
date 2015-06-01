From: ijc@debian.org (Ian Campbell)
Date: Mon, 01 Jun 2015 22:07:37 +0100
Subject: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
In-Reply-To: <20150601025050.GB11354@lunn.ch>
References: <1433068534.5748.276.camel@debian.org>
 <20150601025050.GB11354@lunn.ch>
Message-ID: <1433192857.5748.288.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
> You might also want to try 
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
> 
> In particular the first patch.

That did the trick, thanks!

Ian.
