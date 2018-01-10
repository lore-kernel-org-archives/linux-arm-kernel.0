From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 10 Jan 2018 19:59:31 +0200
Subject: [PATCH 2/3] dt-bindings: pinctrl: Add a ngpios-ranges property
In-Reply-To: <20180110163733.GH21040@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-3-sboyd@codeaurora.org>
 <CACRpkdaN6vmV4L4U76DvD5BN+j1RYCQakTysA+GGPdT8Chc-iw@mail.gmail.com>
 <20180110163733.GH21040@codeaurora.org>
Message-ID: <1515607171.7000.879.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-01-10 at 08:37 -0800, Stephen Boyd wrote:
> On 01/10, Linus Walleij wrote:
> > On Wed, Jan 10, 2018 at 2:58 AM, Stephen Boyd <sboyd@codeaurora.org>
> > wrote:

> for the qcom driver it was all fine
> because all three concepts: irq, gpios, and pins have a one to
> one relationship.

Just a side note: While it might be the case for most of the
controllers, don't assume it's a generic case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
