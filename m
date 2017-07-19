From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 19 Jul 2017 02:11:06 -0700
Subject: [PATCH] gpio: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-23-robh@kernel.org>
References: <20170718214339.7774-23-robh@kernel.org>
Message-ID: <CADtm3G42P3CG7rwmDu7QLJQY8+k0PmpJe3jE2BbcTOLxO3Bsig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 2:43 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For the brcmstb part,
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
