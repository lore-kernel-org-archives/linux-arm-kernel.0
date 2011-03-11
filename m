From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 23:46:51 +0200
Subject: [PATCH 1/4] ARM: PXA: PXAFB: rework pxafb overlay memory
	management
In-Reply-To: <201103112234.10904.marek.vasut@gmail.com>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
	<201103112234.10904.marek.vasut@gmail.com>
Message-ID: <201103112346.51471.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 23:34:10 Marek Vasut wrote:
> > +	if (ofb->usage++ == 0)
> 
> TBH I don't like this notation, it feels hard to read. Can you split that
> ofb-
> 
> >usage++ into two parts ?
> 
> Cheers

It's not deprecated by kernel codestyle, looks ok and works ok, but I'll 
change it if one more person argues against it :)

Regards
Vasily
