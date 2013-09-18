From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Sep 2013 18:35:49 +0200
Subject: mvneta: oops in __rcu_read_lock on mirabox
In-Reply-To: <CACzLR4t2ABZdRk40VUhLtDKXX2PQiSVoQZQ4coQkNkvETnY6Rw@mail.gmail.com>
References: <20130915205701.5c61a444@skate> <20130916065047.GH27487@1wt.eu>
 <20130916175152.4e013457@skate>
 <CACzLR4twTNjzU8hK3L1cYUXnEH1ydwY6jnYoOG+9vLB3-4uQ4w@mail.gmail.com>
 <20130916163937.GC3188@1wt.eu> <20130916164412.GD3188@1wt.eu>
 <CACzLR4ssOPsmYaEh2ohe4HL5j+67keDYnmR4YezNB=aO7Pj5kA@mail.gmail.com>
 <20130916174708.GG3188@1wt.eu>
 <20130916182807.GO12758@n2100.arm.linux.org.uk>
 <CACzLR4suLD90p=sEhB-qg1u35t66zKfrGQref1jX42fEfu3D8g@mail.gmail.com>
 <20130917060111.GB9325@1wt.eu>
 <CACzLR4t2ABZdRk40VUhLtDKXX2PQiSVoQZQ4coQkNkvETnY6Rw@mail.gmail.com>
Message-ID: <20130918183549.3e7b8f4c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ethan Tuttle,

On Tue, 17 Sep 2013 23:30:56 -0700, Ethan Tuttle wrote:
> On Mon, Sep 16, 2013 at 11:01 PM, Willy Tarreau <w@1wt.eu> wrote:
> > Next step should be that you test both kernels to be sure.
> 
> Thanks for the kernel images, Willy.  I'm still experimenting but
> initial results are strange: I haven't seen a crash from the -ethan
> image you provided, nor by a kernel with that config that I built
> myself.  The config is only different from my crashing config by a few
> options.  So perhaps some combination of options prevents the crash.
> I'll see if I can narrow it down.

A toolchain generating some crappy code maybe? Ethan, Willy, comparing
your toolchain (compiler version, origin of the toolchain) could be
interesting.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
