From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Aug 2015 15:26:14 +0100
Subject: [PATCH v2 5/6] mailbox: Add generic mechanism for testing
 Mailbox Controllers
In-Reply-To: <CABb+yY2N6=oTrwni0tw1WffLv-udtBWh9LJR43EMVqYf+i2xUg@mail.gmail.com>
References: <20150813091914.GB8782@x1>
 <CABb+yY0cgbtM68-E_Xqgh5O6GRLXESYTLa5WcAwUBoVL3ufrxA@mail.gmail.com>
 <20150813102335.GC8782@x1>
 <CABb+yY3z7p97eOhncQ2i+g6yoYGfDgSN9BDPKmiDaVLa3oPocA@mail.gmail.com>
 <20150813110008.GD8782@x1>
 <CABb+yY34i=VUnswUE21vgeQYAGOS=7uwvdnTAFFgYkTV0CFk=w@mail.gmail.com>
 <20150813114005.GF8782@x1>
 <CABb+yY2OH16mgOwi=yH_eEHQN2Ck2x5xtVk-p-8Un9gGmcACdw@mail.gmail.com>
 <20150813130736.GG8782@x1>
 <CABb+yY2N6=oTrwni0tw1WffLv-udtBWh9LJR43EMVqYf+i2xUg@mail.gmail.com>
Message-ID: <20150813142614.GH8782@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Aug 2015, Jassi Brar wrote:

> On Thu, Aug 13, 2015 at 6:37 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Now just agree with me that mbox_request_chan() should fail on request
> > of a known bad configuration request and I can code all this up and
> > re-submit. :D
> >
> You make me look like a jerk :(   My problem is not with validation as
> such. I see problem in the way you implement that makes validation
> necessary. I'll explain step-by-step in the driver post.

That wasn't the intention, don't be so sensitive. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
