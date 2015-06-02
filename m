From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 2 Jun 2015 17:52:22 +0200
Subject: [PATCH v3 0/6] i2c: at91: add support to FIFOs and alternative
 command
In-Reply-To: <20150602153622.GB2661@katana>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
 <20150602152647.GA2806@odux.rfo.atmel.com>
 <20150602153622.GB2661@katana>
Message-ID: <20150602155222.GB2806@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 12:36:28AM +0900, Wolfram Sang wrote:
> 
> > If you send a new version, could you add stable in Cc to patch 3/6:
> 
> No need to send a new version just because of an additional ack. I can
> apply that. However...
> 
> > Cc: stable at vger.kernel.org #3.10 and later
> > If not, Wolfram could you do it please?
> 
> The problem with 3/6 is that it seems to depend on 1/6 which is a
> cleanup patch. If cleaning up is not essential for the bugfix, the
> latter should be done first. To avoid exactly this problem.
> 
> 

I was thinking the same so I have tried to cherry-pick the patch on a 3.10.79
and it didn't cause any conflicts so I thought it could be sent to stable as
is.
