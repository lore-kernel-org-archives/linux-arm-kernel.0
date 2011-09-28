From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 14:18:14 +0200
Subject: [PATCHv2 08/10] ARM: u300: convert to MULTI_IRQ_HANDLER
In-Reply-To: <20110928120340.GH17204@pulham.picochip.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-9-git-send-email-jamie@jamieiles.com>
	<CACRpkdYOdWA2vg2zq+nhOPSvPN7zdy9NVsOcqfZ7i9W5Sq5cpw@mail.gmail.com>
	<20110928120340.GH17204@pulham.picochip.com>
Message-ID: <CACRpkdarydeYAyOV8Cm134TtPeh9_qFSqWPkvpZjUE9yPNNtJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 2:03 PM, Jamie Iles <jamie@jamieiles.com> wrote:

>> vic_single_handle_irq() needs to be modified to handle several
>> ranges or atleast two.
>
> The platform IRQ handler is actually vic_handle_irq() that internally
> calls vic_single_handle_irq() for each registered vic (in the order of
> registration).

Ah I get it I'm dead wrong as usual :-)

I tried to apply them to test but Iget into dependency trouble with
the referenced required patches, do you have some handy
git branch with all stuff applied in order that I can pull in and
test off?

Yours,
Linus Walleij
