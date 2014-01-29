From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Jan 2014 11:12:51 -0600
Subject: [RFC PATCH v2 09/14] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <CAL_JsqLVr1gSLArqtfOiHce+u6ZK8FiKMX0o9bvMrMoGGhATvg@mail.gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-10-git-send-email-b.brezillon.dev@gmail.com>
 <CAL_JsqLVr1gSLArqtfOiHce+u6ZK8FiKMX0o9bvMrMoGGhATvg@mail.gmail.com>
Message-ID: <CAL_JsqL_zBJezPS04tTFMyvzHma3vb-NbqFD3Fc89zceRS5KOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 11:11 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Jan 29, 2014 at 8:34 AM, Boris BREZILLON
> <b.brezillon.dev@gmail.com> wrote:
>> Add the sunxi NAND Flash Controller dt bindings documentation.
>>

[snip]

>> +- onfi,nand-timing-mode : mandatory if the chip does not support the ONFI
>> +  standard.
>
> Add to generic nand binding.

NM, I see you did this.

Rob
