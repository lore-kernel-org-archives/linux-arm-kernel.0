From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:28:38 +0200
Subject: [PATCH V5 2/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <20140630125339.GA21390@leverpostej>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
 <1403823587-23404-3-git-send-email-fkan@apm.com>
 <20140630125339.GA21390@leverpostej>
Message-ID: <CACRpkdZ18SsRBBbngSVyxR0GFkC0kLD4OHm9RJmgZDLXbqvOBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 2:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 26, 2014 at 11:59:46PM +0100, Feng Kan wrote:

>> +- #gpio-cells: Should be two.
>> +     - first cell is the pin number
>> +     - second cell is used to specify optional parameters (unused)
>
> Why is there an unused cell?
>
> Why not just make this a single cell if the binding defines no valid
> parameters?

I don't get this either. The only reason would be that this cell
should contain flags (such as open collector) the code for using
it being inplemented later.

If the controller is too primitive to use such flags it should be onecell.

Yours,
Linus Walleij
