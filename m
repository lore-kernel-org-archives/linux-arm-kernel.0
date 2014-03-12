From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Mar 2014 22:05:38 -0300
Subject: Freescale PFUZE100 PMIC
In-Reply-To: <CACUGKYN4uaT0xn4fMCqVNXeKYSf_WP+GkpkAb6vagQeGFdJUmw@mail.gmail.com>
References: <CACUGKYN4uaT0xn4fMCqVNXeKYSf_WP+GkpkAb6vagQeGFdJUmw@mail.gmail.com>
Message-ID: <CAOMZO5DKpz6gRP-9Zvpmdq94UxRzFV=Rfa1mju7Y5JzJ5xOisg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 9:41 PM, John Tobias <john.tobias.ph@gmail.com> wrote:

> After loading the driver, I was getting an error:
> pfuze100-regulator 0-0008: unrecognized pfuze chip ID!

Double check the IOMUX settings for the I2C pins.

You can take a look at imx6sl-evk.dts from linux-next as we do support
pfuze100 there.

Regards,

Fabio Estevam
