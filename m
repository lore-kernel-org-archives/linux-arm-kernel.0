From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 16:12:56 +0100
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <20130126150611.GL1758@titan.lakedaemon.net>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch>
 <20130126150611.GL1758@titan.lakedaemon.net>
Message-ID: <20130126151256.GF29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Something is not right here, or i'm not understanding something. DT
> > devices should not need code like this, only devices not yet using
> > DT....
> 
> Yes, hence my frustration yesterday.  I posted this so everyone could
> see exactly what I was working with, and perhaps spot something I had
> missed.  Looks like you did in your followup to Sebastian.

Hi Jason

I have it fixed now. I just sent some patches, which you can insert or
squash as appropriate.

       Andrew
