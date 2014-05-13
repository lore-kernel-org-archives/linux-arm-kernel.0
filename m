From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 13 May 2014 11:13:33 +0100
Subject: [PATCH] mmc: dw_mmc: change to use recommended reset procedure
In-Reply-To: <CAPz6YkW5CfdMTW3W-zdK29RCv4q7u9rAMr6AjWip3beuhgsv5g@mail.gmail.com>
References: <1395834374-1988-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOJYsC9OUOrYrvKg_iC5Z6dZ0mqW3-y=UXHtCr99=gQBXw@mail.gmail.com>
 <536C2C31.8000209@samsung.com>
 <CAPz6YkXGH96mjeePwUSRmPX4Y1YXYif+N+BRKsTwtNxtRq3xoQ@mail.gmail.com>
 <536C594A.5080107@samsung.com> <536C84A0.6020403@samsung.com>
 <CAPz6YkUjLmWXvoCkuY8vAwLHksf0Uit6gWP-ADWBbN3NDJBo-w@mail.gmail.com>
 <CAPz6YkW5CfdMTW3W-zdK29RCv4q7u9rAMr6AjWip3beuhgsv5g@mail.gmail.com>
Message-ID: <5371F04D.7060007@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/05/14 22:44, Sonny Rao wrote:
> Doug mentioned that James Hogan might have an answer.  James, are
> there Imgtec SoCs which use dw_mmc and use DMA but don't use the
> IDMAC?  If so, we can add that support into this reset procedure
> patch.

Yes, the Toumaz TZ1090 SoC has the dw_mmc configured without an IDMAC,
so it uses the IMG DMAC block instead.

Cheers
James
