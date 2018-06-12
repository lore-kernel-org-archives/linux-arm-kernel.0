From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 12 Jun 2018 01:06:05 -0700
Subject: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
In-Reply-To: <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
 <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
 <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
 <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
Message-ID: <152879076578.16708.6230985334183790836@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Codrin Ciubotariu (2018-06-07 03:30:14)
> > 
> > Seems to me that clock additions could use a new binding and we start
> > with a new driver that handles these few clocks initially. But I
> > haven't looked whether both can coexist.
> 
> Mark already applied to broonie/sound.git the I2S bindings that have a 
> phandle to this clock. If I am to change #clock-cells to 1, I will have 
> to change the bindings to include the clock-id.
> Which approach should I take now?
> 

You're talking about changing the example in the binding doc? That
doesn't really matter. Consumer side of the provider has to match the
cell count from the provider so it doesn't really need to be 'fixed' in
the example at all.
