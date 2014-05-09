From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 09 May 2014 09:18:00 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IEFkZCBzdXBwb3J0IGZvciB0aGUgY3B1?=
 =?UTF-8?B?aW14MjcgYm9hcmQgZnJvbSBFdWtyZWEgYW5kIGl0cyBiYXNlYm9hcmQ=?=
In-Reply-To: <20140509050827.GN2794@dragon>
References: <1399556281-28067-1-git-send-email-shc_work@mail.ru>
 <20140509050827.GN2794@dragon>
Message-ID: <1399612680.993476399@f333.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fri, 9 May 2014 13:08:29 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> On Thu, May 08, 2014 at 05:38:01PM +0400, Alexander Shiyan wrote:
> > This patch adds support for the cpuimx27 board from Eukrea and its
> > baseboard. This change is intended to further remove non-DT support
> > for this board.
> > 
> > Reviewed-by: Eric B?nard <eric@eukrea.com>
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
....
> > +	uart8250 at 3,200000 {
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_uart8250_1>;
> > +		compatible = "ns8250";
> > +		clk = <&clk14745600>;
> 
> Shouldn't the property name be 'clocks'?

Ah, yes. Thanks.

---
