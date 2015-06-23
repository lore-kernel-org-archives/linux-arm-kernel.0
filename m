From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jun 2015 13:41:46 -0300
Subject: mx6 hdmi resolution behaviour
Message-ID: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a imx6q-cubox-i running 4.1 kernel I am getting 1920x1080 HDMI
resolution if I boot the board with the HDMI cable connected.

If I boot it without the HDMI cable and then connect it afterwards,
the resolution goes to only 1024 x 768 and the following IPU message
is seen:

[   16.310548] imx-ipuv3 2400000.ipu: videomode adapted for IPU restrictions

Shouldn't we get 1920x1080 in this case as well?

Regards,

Fabio Estevam
