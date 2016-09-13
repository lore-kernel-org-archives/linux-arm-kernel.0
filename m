From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Tue, 13 Sep 2016 15:34:17 +0200
Subject: [PATCH v3 3/9] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <20160909141710.GF30871@lunn.ch>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-4-git-send-email-clabbe.montjoie@gmail.com>
 <20160909141710.GF30871@lunn.ch>
Message-ID: <20160913133417.GC31990@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 04:17:10PM +0200, Andrew Lunn wrote:
> > +Optional properties:
> > +- allwinner,tx-delay: TX clock delay chain value. Range value is 0-0x07. Default is 0)
> > +- allwinner,rx-delay: RX clock delay chain value. Range value is 0-0x1F. Default is 0)
> 
> What are the units? pS? nS?
> 
>      Andrew

No units, only raw number.
I will add a comment for this.

Regards

Corentin Labbe
