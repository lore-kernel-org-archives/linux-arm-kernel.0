From: sjur.brandeland@stericsson.com (Sjur BRENDELAND)
Date: Mon, 2 Jul 2012 17:15:13 +0200
Subject: [PATCH] remoteproc: block premature rproc booting
In-Reply-To: <CAK=WgbZb367zq0QCUuwFU+KtBY0gw_+rsN9fm2YnM-heT+54jA@mail.gmail.com>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
 <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
 <4FCD276A.80505@codeaurora.org>
 <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
 <CAK=WgbZb367zq0QCUuwFU+KtBY0gw_+rsN9fm2YnM-heT+54jA@mail.gmail.com>
Message-ID: <81C3A93C17462B4BBD7E272753C10579232F86BE4C@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

> Sjur, Ludovic, Loic - what remoteproc API are you using today?
> 
> We'd like to get rid of the existing get/put interface and instead
> have everyone use the boot/shutdown one, just like rpmsg is doing
> today.
> 
> Are you ok with this change?

Yes, I'm ok with this,
but I cannot answer for Loic and Ludovic.

Regards,
Sjur
