From: olof@lixom.net (Olof Johansson)
Date: Fri, 8 Nov 2013 15:17:34 -0800
Subject: [PATCH] ARM: make OABI default to off
In-Reply-To: <alpine.LFD.2.03.1311081809050.15571@syhkavp.arg>
References: <20131106211352.GA24006@www.outflux.net>
 <alpine.LFD.2.03.1311081809050.15571@syhkavp.arg>
Message-ID: <CAOesGMhCa5qFsJZ56ktA3MA+arx4WzSzkchZp+qKZmt=nKhpug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 3:13 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 6 Nov 2013, Kees Cook wrote:
>
>> Given recent discussions about the lack of OABI in the wild, switch
>> CONFIG_OABI_COMPAT to off-by-default to encourage more system builders
>> to avoid it.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Yeah, sorry for the delay:

Acked-by: Olof Johansson <olof@lixom.net

(send to the patch tracker :)

-Olof
