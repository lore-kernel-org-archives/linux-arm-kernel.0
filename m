From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 19 Dec 2014 10:01:32 +0200
Subject: [PATCH 0/4] Support qcom GDSC hardware
In-Reply-To: <534D72E5.1000805@codeaurora.org>
References: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
 <534D72E5.1000805@codeaurora.org>
Message-ID: <1418976092.27549.4.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2014-04-15 at 10:56 -0700, Stephen Boyd wrote:
> On 04/04/14 11:45, Stephen Boyd wrote:
> > These patches add support for the multimedia GDSCs on the
> > apq8074 dragonboard. The first two patches (and potentially the last)
> > should go through Mike's tree and the DTS patch should go through
> > the qcom tree. Patches are based on v3.14. The probe will conflict with
> > patches I sent to consolidate things. I'll rework these patches on top of
> > that if the gdsc.c file is acked/reviewed.
> 
> Any comments?
> 

Hi,

It will nice if we can progress on this. They are several drivers posted 
already which depends on these regulators, USB3.0 and PCIe, at least.

Thank you.
Ivan
