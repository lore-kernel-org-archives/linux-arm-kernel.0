From: w@1wt.eu (Willy Tarreau)
Date: Tue, 19 Dec 2017 06:34:59 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <20171219011315.2fa0f9d1@xps13>
References: <20171217190056.GA1107@1wt.eu>
 <CAAEAJfArtxcWgcjHAb__3BQxWEBgWU8uWtHGYETc-m9eUs91nA@mail.gmail.com>
 <20171217211650.GA6815@1wt.eu> <20171217222611.59f9031b@bbrezillon>
 <20171217224617.1f9b8b84@xps13> <20171218063715.GA20461@1wt.eu>
 <20171218070617.GA16559@1wt.eu> <20171218112208.0057634d@xps13>
 <20171218215217.GA17755@1wt.eu> <20171219011315.2fa0f9d1@xps13>
Message-ID: <20171219053459.GA7756@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 01:13:15AM +0100, Miquel RAYNAL wrote:
> Boris' fix wouldn't apply anyway as it was written for pxa3xx_nand.c
> and here you are using marvell_nand.c and the code is really different.

yep I noticed already during the first problem, I couldn't even find
where the equivalent part of the code was located.

> Thanks again for your help, reviews or tested-by's are welcome for this
> driver ;)

do not hesitate to add my tested-by on your current patchset if that helps.

Willy
