From: martinwguy@gmail.com (Martin Guy)
Date: Wed, 21 Apr 2010 12:49:36 +0100
Subject: SPI trouble on Colibri 270 (PXA)...
In-Reply-To: <x2hf17812d71004210442n227bb05djd4578569819ca013@mail.gmail.com>
References: <4BCD96F0.5010506@viketoft.se>
	<q2sf17812d71004200614n58fb6cabgd0686d3ab6788b23@mail.gmail.com>
	<4BCDC645.5090001@viketoft.se>
	<201004211144.41781.marek.vasut@gmail.com>
	<j2tf17812d71004210347gd9ad8530w409b8d6e3a732c1c@mail.gmail.com>
	<p2y56d259a01004210411ie5f4b723n6cfd25e96333813@mail.gmail.com>
	<x2hf17812d71004210442n227bb05djd4578569819ca013@mail.gmail.com>
Message-ID: <i2l56d259a01004210449l3adf9cc7v60bc83e8f57cf032@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/10, Eric Miao <eric.y.miao@gmail.com> wrote:
>  If CS isn't expected to be dropped between transfers within a single message,
>  I guess that's possible with ".cs_change", otherwise might be not feasible with
>  the current code.

That is already in; we are trying to make it work as it should

   M
