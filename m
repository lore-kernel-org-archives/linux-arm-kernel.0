From: robherring2@gmail.com (Rob Herring)
Date: Sun, 7 Jul 2013 15:01:24 -0500
Subject: [PATCH RFC 9/9] ARM: debug: move PL01X debug include into
 arch/arm/include/debug/
In-Reply-To: <E1UvoS8-0006IF-TE@rmk-PC.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
 <E1UvoS8-0006IF-TE@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_JsqJ_rKOKo=KoAu+bWeX3U+4jeiawQ7xBDbF18XO3_J23Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 7, 2013 at 7:52 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Now that the PL01X debug include can mostly stand alone without
> requiring platforms to provide any macros, move it into the debug
> directory so it can be directly included.  This allows us to get rid of
> a lot of debug-macros include files.
>
> The autodetect case for Versatile Express and the ux500 are left alone;
> these are more complicated implementations.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Certainly a move in the right direction. For highbank:

Acked-by: Rob Herring <rob.herring@calxeda.com>
