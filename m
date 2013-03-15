From: chen.gang.flying.transformer@gmail.com (Chen Gang F T)
Date: Fri, 15 Mar 2013 19:11:36 +0800
Subject: [Suggestion] Latest randconfig build errors for Head.S
In-Reply-To: <201303151056.55819.arnd@arndb.de>
References: <51415428.1070401@asianux.com> <514270D2.9010205@asianux.com>
 <CAAQYJAvXLV38shKncAKKqgQ9G0SnXjh+=aJHBdhd29yzVtL80A@mail.gmail.com>
 <201303151056.55819.arnd@arndb.de>
Message-ID: <514301E8.9040201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?03?15? 18:56, Arnd Bergmann ??:
> Right. The fact that as prints a warning for those instructions makes sense
> given that we are telling it we want to run on *all* ARM architectures,
> and that ARMv8 has deprecated them officially.
> 
> Of course, what is bogus about this is the "NULL" part rather than printing
> the text that was meant to come out to explain the situation.  I don't
> know how to report that bug other than what I tried before, but if it gets
> fixed by printing the right text, we will still want to build a kernel
> without getting any warnings.

  excuse me, my English is not quite well.

  I guess your meaning is:
    "that bug" means the toolchain's bug (need toolchain people fix it).
    prefer to apply your patch, before "that bug" is fixed (we don't know when)

  is it correct ?

  thanks.

-- 
Chen Gang

Flying Transformer
