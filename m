From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 May 2013 10:17:22 +0200
Subject: [PATCH 1/2] gpiolib: add gpio_export_with_name
In-Reply-To: <CACRpkdZMj-Xin5PMDWavaWOTCSZF3NBWXk4fG4QXsJzhwBcs_Q@mail.gmail.com>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <1353492849-29397-1-git-send-email-plagnioj@jcrosoft.com>
 <20121126135911.2F1D33E187C@localhost> <51A719A5.50906@epfl.ch>
 <CACRpkdb9F+wJ0hkNqPTP34r3JAEp2s07Q8U24fD6oCdj7MqCFA@mail.gmail.com>
 <51A7B8CD.4080702@epfl.ch>
 <CACRpkdZMj-Xin5PMDWavaWOTCSZF3NBWXk4fG4QXsJzhwBcs_Q@mail.gmail.com>
Message-ID: <51A85C92.4090701@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On 05/30/2013 11:11 PM, Linus Walleij wrote:
> On Thu, May 30, 2013 at 10:38 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
>
>> Indeed, I work in a robotics lab :-) One of our board (mach-imx/
>> mx31moboard*.c) controls for example the multiplexing of two cameras
>> sharing the same acquisition bus (I know, a bit hackish).
>> I developed a similar board with an OMAP3. Such control do not
>> fit well in the above-mentioned cases, but we do not need RT processes.
>
> It does seem to fit well with V4L and/or the media controller
> framework though, or is this one of those "oh, we don't really
> like to use V4L so we have this special hack instead" things?
>

Sorry, I was not aware of this mux capability inside V4L. Thank
you. So we can live without gpio-export for most of our hardware.

Regards,

Florian
