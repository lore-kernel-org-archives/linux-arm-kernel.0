From: robherring2@gmail.com (Rob Herring)
Date: Wed, 19 Mar 2014 11:14:43 -0500
Subject: [PATCH] Documentation: dt: list all compatible strings for at91
In-Reply-To: <1395224808-10133-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395224808-10133-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CAL_Jsq+sctq85ZhqKyVa7=r5A0FEDKu36692rRJufyca1gzF6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 5:26 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Avoids getting the newly introduced warning:
> WARNING: DT compatible string "atmel,at91sam9g45-adc" appears un-documented -- check ./Documentation/devicetree/bindings/
> +                               compatible = "atmel,at91sam9g45-adc";
>
> Introduced by:
> bff5da433525 checkpatch: add DT compatible string documentation checks

We should fix checkpatch instead. There are some fixes in progress,
but I don't think it covers this issue. I'm puzzled by this one as I
thought I checked for this case.

Rob
