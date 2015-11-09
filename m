From: slash.tmp@free.fr (Mason)
Date: Mon, 9 Nov 2015 17:07:27 +0100
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <yw1xtwov5gh1.fsf@unicorn.mansr.com>
References: <563B3749.50701@free.fr> <20151105151559.GA16666@lunn.ch>
 <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
 <5640B877.4020108@free.fr> <yw1xtwov5gh1.fsf@unicorn.mansr.com>
Message-ID: <5640C4BF.2010204@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2015 16:40, M?ns Rullg?rd wrote:

> The simplest solution for you is probably to add a quick and dirty DT
> binding to the old driver.  If it doesn't use any driver-specific
> platform data struct, you only need to set .of_match_table in the
> struct platform_driver.  If there is a platform data struct, you'll also
> need to write some code to populate it from DT properties.  It shouldn't
> take more than a few minutes per driver in most cases.

I'll try that approach, although I fear that "a few minutes per driver"
is an optimistic assessment.

> To get those drivers accepted upstream will obviously take a bit more
> work.

AKA "rewrite from scratch" :-)

Regards.
