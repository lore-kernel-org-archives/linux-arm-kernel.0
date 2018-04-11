From: joel@jms.id.au (Joel Stanley)
Date: Wed, 11 Apr 2018 21:22:30 +0930
Subject: [PATCH v3 05/10] ARM: dts: aspeed: peci: Add PECI node
In-Reply-To: <20180410183212.16787-6-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-6-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8Xf7ta43K=POx8J6bAdjvX=wCzy-+HWqHsm+RstQxeetCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit adds PECI bus/adapter node of AST24xx/AST25xx into
> aspeed-g4 and aspeed-g5.
>

The patches to the device trees get merged by the ASPEED maintainer
(me). Once you have the bindings reviewed you can send the patches to
me and the linux-aspeed list (I've got a pending patch to maintainers
that will ensure get_maintainers.pl does the right thing as far as
email addresses go).

I'd suggest dropping it from your series and re-sending once the
bindings and driver are reviewed.

Cheers,

Joel
