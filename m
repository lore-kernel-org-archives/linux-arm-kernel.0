From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 11 Feb 2014 10:20:55 +0100
Subject: [PATCH 00/12] ARM: S3C24XX: convert s3c2410,
 s3c2440 s3c2442 to common clock framework
In-Reply-To: <CAL5jtJm=Ehwk2ZyCJaW0NfMn8XM893r1hdCVWs2skMv4+M7yXQ@mail.gmail.com>
References: <201312131356.40755.heiko@sntech.de> <52F7DD6E.8070303@gmail.com>
 <CAL5jtJm=Ehwk2ZyCJaW0NfMn8XM893r1hdCVWs2skMv4+M7yXQ@mail.gmail.com>
Message-ID: <4099437.QudIaVHrIN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Am Dienstag, 11. Februar 2014, 11:46:13 schrieb Kukjin Kim:
> 2014-02-10 1:26 GMT+05:30 Tomasz Figa <tomasz.figa@gmail.com>:
> > 
> > For patches 4, 5, 9, 10, 11, 12:
> > 
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > 
> > For patches 6, 7:
> > 
> > Acked-by: Tomasz Figa <t.figa@samsung.com>
> 
> Really nice series.
> Heiko, thanks for your effort and Tomasz, thanks for your review and ack.
> 
> OK, I'll apply this whole series and this will be sent to arm-soc in this
> week.

not this fast :-)

Tomasz hat some comments about the two clk-drivers included, which I'll need 
to address first.

Also, this series, as well as the other two at the moment conflict with Tomasz' 
clock-pm changes. Our (Tomasz and me) current plan was for me to respin the 3 
ccf conversion series against his clock-pm series, which I hope to do in the 
next two days or so.


Heiko
