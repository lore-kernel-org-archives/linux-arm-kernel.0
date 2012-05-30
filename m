From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 May 2012 16:12:13 -0700
Subject: [PATCH] ARM: LPC32xx: Adjust dts files to gpio dt binding
In-Reply-To: <1337423333-24356-1-git-send-email-stigge@antcom.de>
References: <1337423333-24356-1-git-send-email-stigge@antcom.de>
Message-ID: <CAOesGMiUccXi6JVu2zqYizgV_076Ek-A+KyrfLGFfw8xELaSdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 3:28 AM, Roland Stigge <stigge@antcom.de> wrote:
> The GPIO devicetree binding in 3.5 doesn't register the various LPC32xx GPIO
> banks via DT subnodes but always all at once, and changes the gpio referencing
> to 3 cells (bank, gpio, flags). This patch adjusts the DTS files to this
> binding that was just accepted to the gpio subsystem.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Thanks, applied to fixes for 3.5.


-Olof
