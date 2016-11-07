From: aford173@gmail.com (Adam Ford)
Date: Mon, 7 Nov 2016 09:20:38 -0600
Subject: [PATCH] ARM: dts: imx6: Add support for Logic PD SOM and Baseboard
In-Reply-To: <CAOMZO5BVYchz8qrUn8mssn3L7AbD0pvFkKy0zp2CJmsG+hzVxA@mail.gmail.com>
References: <1469030786-28424-1-git-send-email-aford173@gmail.com>
 <20160809082400.GR4678@tiger>
 <CAHCN7x+YopHVNxh4Vi5o1d=S3FFkoz45dNmgHMgs1sAQqaL77A@mail.gmail.com>
 <20161105070043.GA5597@dragon>
 <CAHCN7xJ=KK-=5sVu0Or5bep-cdk3hq4+a3gFj-W0bCcVhQyWNw@mail.gmail.com>
 <CAOMZO5DOjGAJytMruLT7mZg2BEbNB2FW-Fyo0Xx0tsr-sZ=6Rw@mail.gmail.com>
 <CAOMZO5BVYchz8qrUn8mssn3L7AbD0pvFkKy0zp2CJmsG+hzVxA@mail.gmail.com>
Message-ID: <CAHCN7xKKfjDp=p=tmLN2ooKZYxGD9-oFi0pGBMrmmjjH+Ogrbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2016 at 9:16 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Nov 7, 2016 at 1:11 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> You can write the regulators without the container as follows:
>
> Or just look at arch/arm/boot/dts/imx6qdl-ts4900.dtsi for an example.

Thank you for the hint.  It was the reg = <0> causing the issue.  Once
I removed these, It all went away.
I appreciate the patience.  This is my first IMX6 board.  I'll push a
V2 Patch shortly.

adam
