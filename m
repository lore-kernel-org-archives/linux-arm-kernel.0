From: joshc@ni.com (Josh Cartwright)
Date: Wed, 18 Feb 2015 10:34:12 -0600
Subject: __HAVE_ARCH_CMPXCHG on ARM?
In-Reply-To: <20150218104459.GD28763@linutronix.de>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
 <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
 <20150218104459.GD28763@linutronix.de>
Message-ID: <20150218163412.GA23160@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 11:44:59AM +0100, Sebastian Andrzej Siewior wrote:
> * Josh Cartwright | 2015-02-03 13:27:30 [-0600]:
> 
> >                 native         native
> >                cmpxchg (UP)   cmpxchg (SMP)    __HAVE_ARCH_CMPXCHG
> >         xtensa     X               X
> 
> This one does not always have cmpxchg on UP (only the SMP variant which
> provides atomic operation).

Ah!  Thanks for double checking my work; my eyes started to glaze over
after looking at the other 29 architectures.

  Josh
