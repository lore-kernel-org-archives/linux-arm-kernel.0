From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Feb 2015 19:10:21 -0200
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <1705379122.406018.1423686677196.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
 <54DA0DE7.5050708@i2se.com>
 <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
 <462270270.419156.1423603473431.JavaMail.open-xchange@oxbaltgw02.schlund.de>
 <CAOMZO5B4mxP6RBkbsbj=wC6bZJgtreoo5S_NhYuki6kW=Y=QFw@mail.gmail.com>
 <1705379122.406018.1423686677196.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Message-ID: <CAOMZO5ChJiHiUBhrRf_qqi7gTLvPp08fsfRBK+GVzvrqimKinw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 6:31 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

>> I always get 0x5e5b5513 with or without your patch.
>
> very strange. Do you have any idea why IO1_STABLE is permanent low?

On my case it is always 1.

> Can you confirm the behavior according to your flash issue?

In my tests IO1_STABLE stays the same.

> I think it would be the best to revert my patch. Sorry for the trouble.

To be on the safe side, I agree.

Could you please send a revert patch?

Thanks
