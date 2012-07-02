From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 2 Jul 2012 18:19:18 +0300
Subject: [PATCH] remoteproc: block premature rproc booting
In-Reply-To: <81C3A93C17462B4BBD7E272753C10579232F86BE4C@EXDCVYMBSTM005.EQ1STM.local>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
 <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
 <4FCD276A.80505@codeaurora.org>
 <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
 <CAK=WgbZb367zq0QCUuwFU+KtBY0gw_+rsN9fm2YnM-heT+54jA@mail.gmail.com>
 <81C3A93C17462B4BBD7E272753C10579232F86BE4C@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <CAK=WgbYG8kuzYUi54Kh4udsrOiX_f1E=1XW+TpeYhoyPtXwq-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2012 at 6:15 PM, Sjur BRENDELAND
<sjur.brandeland@stericsson.com> wrote:
>> Sjur, Ludovic, Loic - what remoteproc API are you using today?
>>
>> We'd like to get rid of the existing get/put interface and instead
>> have everyone use the boot/shutdown one, just like rpmsg is doing
>> today.
>>
>> Are you ok with this change?
>
> Yes, I'm ok with this,
> but I cannot answer for Loic and Ludovic.

Thanks, Sjur.

I think Ludovic and Loic should be ok with this because their use
cases are very much like OMAP's (mostly rpmsg drivers).

Ohad.
