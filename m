From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 24 Nov 2013 10:16:32 -0800
Subject: crypto dependency in bit sliced AES
In-Reply-To: <20131124075632.GA7807@gondor.apana.org.au>
References: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
 <20131122225256.GG16735@n2100.arm.linux.org.uk>
 <CA+55aFwRWGdA934GQdo6QpEuxRxeECvrpi9ctJWcVQ5pCyF1iw@mail.gmail.com>
 <20131123013924.GA16533@gondor.apana.org.au>
 <CAADWXX9CRRZF3Ewt5sXWQuCdKVVpe_-TdT+BW_MRrMUG2h1eGA@mail.gmail.com>
 <20131124010207.GK16735@n2100.arm.linux.org.uk>
 <20131124075632.GA7807@gondor.apana.org.au>
Message-ID: <CA+55aFxN=kbKJmkjSECokqTx+cBP1GOCTpJuRCebfitiiDP5Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 11:56 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
>
> OK, I've fixed the EHLO header and added an SPF record.  Hopefully
> gmail will stop listing my emails as spam now.

Ok, at least this email came through. And I do see the SPF change:

  Received-SPF: pass (google.com: domain of
herbert at gondor.apana.org.au designates 178.18.16.133 as permitted
sender) client-ip=178.18.16.133;
  Authentication-Results: mx.google.com;
         spf=pass (google.com: domain of herbert at gondor.apana.org.au
designates 178.18.16.133 as permitted sender)
smtp.mail=herbert at gondor.apana.org.au
  Received: from gondolin.me.apana.org.au ([192.168.0.6])

so hopefully the success is indeed permanent.

              Linus
