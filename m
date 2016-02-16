From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 16 Feb 2016 16:12:56 +0000
Subject: [PATCH v3 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <CAHp75VecjR3sBcGmRHFwZPwUjXhPwV-2z4hYYJ7Y+iCOxi8_EA@mail.gmail.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-6-git-send-email-vladimir.murzin@arm.com>
 <CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>
 <56C31F9F.10000@arm.com>
 <CAHp75Vf_4MgdWunQy5hBMH5GGei+OkktFPYY-ZprY0qOEnD=wA@mail.gmail.com>
 <56C32641.4020201@arm.com>
 <CAHp75VecjR3sBcGmRHFwZPwUjXhPwV-2z4hYYJ7Y+iCOxi8_EA@mail.gmail.com>
Message-ID: <20160216161256.234a2be8@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > If you do insist to have a counter I'll add one, but if you are not
> > strong about it I'd prefer to leave it as is.  
> 
> I would wait for Peter Hurley, Alan, or other experienced guys to talk.

I would leave it. Some of the drivers have defensive code of this form,
but mostly because they can be hot unplugged and we don't want to spin
into oblivion because the user ejected a serial card adapter.

Alan
