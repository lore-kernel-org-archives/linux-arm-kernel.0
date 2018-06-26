From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 26 Jun 2018 09:34:10 +0200
Subject: [PATCH v2 14/23] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
In-Reply-To: <20180626033556.bsub25ykdseflsta@tarshish>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-15-miquel.raynal@bootlin.com>
 <20180626033556.bsub25ykdseflsta@tarshish>
Message-ID: <20180626093410.2d9f815c@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, 26 Jun 2018 06:35:56 +0300, Baruch Siach <baruch@tkos.co.il>
wrote:

> Hi Miquel,
> 
> On Mon, Jun 25, 2018 at 05:12:30PM +0200, Miquel Raynal wrote:
> > There are multiple system controllers in CP110. Because all syscon nodes
> > use the same compatible, it is pertinent to use this same file to list
> > IPs inside it. Thus, change the header to be more generic, and align
> > with AP806 file.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> This patch and the file rename in patch #12 should be squashed together, I 
> think.

I was asked multiple times to clearly separate any kind of file
renaming with internal changes because otherwise the reviewing process
is way more complicated. I do agree the changes could be squashed but
now I prefer to let them as is unless I'm explicitly told to do so
after the reviewing process.

Regards,
Miqu?l
