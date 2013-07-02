From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 02 Jul 2013 13:50:57 +0200
Subject: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <CAOMZO5DZufiOjguOCEbe5n0j=w9B5ezBYh0Rejv3zF5Xht5_qQ@mail.gmail.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
 <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
 <51D2BB05.9040201@free-electrons.com>
 <CAOMZO5DZufiOjguOCEbe5n0j=w9B5ezBYh0Rejv3zF5Xht5_qQ@mail.gmail.com>
Message-ID: <51D2BEA1.6010206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 13:45, Fabio Estevam wrote:

> Shouldn't this be
> 
>          i2c at 1 {
>                  reg = <1>; ?
> 

No, we have 4 devices on that mux and 2 pins to select the muxing.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
