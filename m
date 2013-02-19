From: zonque@gmail.com (Daniel Mack)
Date: Tue, 19 Feb 2013 01:07:07 +0100
Subject: Question about fixed-clock
In-Reply-To: <5122BF88.1050007@gmail.com>
References: <5122BF88.1050007@gmail.com>
Message-ID: <CACTFLAME+O4J2eme6Pw5_rGBuVBNLq2cX86WRvoev1W=ZDnnmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 12:55 AM, Daniel Mack <zonque@gmail.com> wrote:
> Hi,
>
> This might be a stupid question, but I'm somehow stuck here. I'm using a
> driver with the following DTS sub-node:
>
>         ref25: ref25M {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <25000000>;
>         };
>
>         clock-generator at 0 {
>                                 /* ... */
>                                 #clock-cells = <1>;

Sorry - this is actually <0>.
