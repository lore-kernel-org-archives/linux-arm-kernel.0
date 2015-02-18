From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 18 Feb 2015 11:44:59 +0100
Subject: __HAVE_ARCH_CMPXCHG on ARM?
In-Reply-To: <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
 <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
Message-ID: <20150218104459.GD28763@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Josh Cartwright | 2015-02-03 13:27:30 [-0600]:

>                 native         native
>                cmpxchg (UP)   cmpxchg (SMP)    __HAVE_ARCH_CMPXCHG
>         xtensa     X               X

This one does not always have cmpxchg on UP (only the SMP variant which
provides atomic operation).

>  Josh

Sebastian
