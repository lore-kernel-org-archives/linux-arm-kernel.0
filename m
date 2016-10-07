From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 7 Oct 2016 13:51:59 -0300
Subject: [PATCH 1/2] ARM: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <20161007160231.GA10773@workstation.local>
References: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
 <20161007141224.GA18011@lime>
 <CAOMZO5CYST3fw1q11RidmSMepsUpaHg91T5gD_c6XA6vsAsJLQ@mail.gmail.com>
 <20161007160231.GA10773@workstation.local>
Message-ID: <CAOMZO5CGzpk3xaSOf9vi80nCHgkYxaueG84QcUK7HM5gtGUFaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 7, 2016 at 1:02 PM, Emil Lundmark <emil@limesaudio.com> wrote:

> I was not aware of that issue before but it seems related. Only the first
> patch in the series is relevant for solving the issue I was experiencing.

Also, in v2 please describe exactly the issue you were experiencing.

Is the issue you observed a regression caused by ba7f4f557eb6 ("clk:
imx: correct AV PLL rate formula")?

If so, please state this in the commit log.
