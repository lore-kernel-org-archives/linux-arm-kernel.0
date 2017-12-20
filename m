From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 20 Dec 2017 14:00:53 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CAK8P3a22-Q6Ksqh3eeoq-iLcs9PA2kZ12Cjp5ibPUKvU8dhbrw@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900> <20171213095257.5cf424fb@jawa>
 <CACRpkdaAYLd6ZcBXQP_SfA1dTyyb4kjOpGoW5DUBgH_9pDDtQQ@mail.gmail.com>
 <CAK8P3a22-Q6Ksqh3eeoq-iLcs9PA2kZ12Cjp5ibPUKvU8dhbrw@mail.gmail.com>
Message-ID: <1513774853.1538.15.camel@Nokia-N900>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed Dec 20 13:50:28 2017 Arnd Bergmann <arnd@arndb.de> wrote:
> I'm generally more interested in the multiplatform conversion than
> the DT conversion, and I think converting this one to multiplatform
> isn't actually that hard, and doesn't have a significant risk for
> regressions, the main work is to convert the clock handling.

If it will be still possible to build the binary kernel of the same size after the conversion, I'm in for testing, otherwise it will not fit into Flash any more...

--
Alex.
