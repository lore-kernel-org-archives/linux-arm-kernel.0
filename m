From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 08:48:14 +0200
Subject: [PATCH v2 2/4] pinctrl: dt-bindings: samsung: add drive strength
 macros for Exynos5433
In-Reply-To: <CACRpkdaE0-4MN+D1THxo7nqQ5qMNZOi7b+cpqE+6-x8RFPuUfA@mail.gmail.com>
References: <CGME20161230041427epcas1p1e4d0dd5e7f9928664c664b7850dbd87a@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-3-andi.shyti@samsung.com>
 <CACRpkdaE0-4MN+D1THxo7nqQ5qMNZOi7b+cpqE+6-x8RFPuUfA@mail.gmail.com>
Message-ID: <20170106064814.khwru5rdulh6jbkl@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 02:30:47PM +0100, Linus Walleij wrote:
> On Fri, Dec 30, 2016 at 5:14 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> 
> > Commit 5db7e3bb87df ("pinctrl: dt-bindings: samsung: Add header with
> > values used for configuration") has added a header file for defining the
> > pinctrl values in order to avoid hardcoded settings in the Exynos
> > DTS related files.
> >
> > Extend samsung.h to the Exynos5433 for drive strength values
> > which are strictly related to the particular SoC and may defer
> > from others.
> >
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> 
> Patch applied with Chanwoo's review tag.

As agreed, applied with your ack to samsung-soc. I put it on separate
branch so I can provide a tag if needed.

Best regards,
Krzysztof
