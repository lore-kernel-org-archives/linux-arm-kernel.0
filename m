From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jul 2018 11:20:21 -0300
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: enable i2c-2 and i2c-4 for
 onboard sensors
In-Reply-To: <CALeDE9N5AnQba5LirHegWgz2_3Rr6cCT_ttTUtg38OdvdegpFA@mail.gmail.com>
References: <20180713171151.24699-1-pbrobinson@gmail.com>
 <CAOMZO5B+1atjr3Ur7EGMJSEbqT8zqWdKZWNHrkyCGvgGM4nJFg@mail.gmail.com>
 <CALeDE9N5AnQba5LirHegWgz2_3Rr6cCT_ttTUtg38OdvdegpFA@mail.gmail.com>
Message-ID: <CAOMZO5BDEnFU__1iSuVpmRKx4SK5F+WFNho-ujTSCobQy-vzSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Jul 16, 2018 at 11:43 AM, Peter Robinson <pbrobinson@gmail.com> wrote:

> Enabling it to turn around and then disable it again seemed counter

Other option would be to put i2c4 with status = "disabled" in the common file
and enable i2c4 on the two dts files that suport it.

> intuitive to me hence the way I did, the WiFi in done that way even
> though it's not on all boards and I would imagine it would cause
> errors on the devices where there isn't wifi although I don't have
> those model(s) to verify.

If the Wifi is not present, then it will not be probed, so it would
not cause problems.
