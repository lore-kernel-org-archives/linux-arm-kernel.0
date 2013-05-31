From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 09:01:44 +0200
Subject: [RFC/PATCH v2 2/2] gpio-rcar: Add DT support
In-Reply-To: <4678059.RuWR6CiQ8n@avalon>
References: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369136406-23800-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdb8GYpx3ASzXB7HX5oEpAUBe-yBo0N5Ep9S+DqoE6oCLw@mail.gmail.com>
 <4678059.RuWR6CiQ8n@avalon>
Message-ID: <CACRpkda4rRWcVkdGPcSvJeQq_KaJE5uxD+0P62Ot8=Xuf2-B+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 3:20 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> I've so far pushed GPIO and pinctrl patches for SH through Simon's tree due to
> the many cross-dependencies between SH arch code and the GPIO and pinctrl
> drivers. As the situation now stabilizes, we could now push the patches
> through their respective subsystem trees.
>
> Simon, Linus, any opinion/preference on that ?

Depends, if they are still large patch sets I'd prefer Simon to
take it, but once the drivers are in place and going to maintenance
mode I'll handle them in pinctrl.

>> The above ranges are part of that document.
>
> What about replacing that with
>
>   - gpio-ranges: Range of pins managed by the GPIO controller.
>
> Please refer to gpio.txt in this directory for details of gpio-ranges property
> and the common GPIO bindings used by client devices.

Go for it!

Yours,
Linus Walleij
