From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 11:16:39 +0200
Subject: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
In-Reply-To: <20120619003427.GA3114@kroah.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
 <20120619003427.GA3114@kroah.com>
Message-ID: <CACRpkda_-JNO0o-FqV2n83ae-sszfPyXef73qoZg=2fZc+vfnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 2:34 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Jun 17, 2012 at 03:44:08PM +0200, Linus Walleij wrote:
>>
>> This switches a bunch of allocation and remapping to use the
>> devm_* garbage collected methods and cleans up the error
>> path and remove() paths consequently.
>> (...)
>
> This patch doesn't apply, what tree did you make it against?

It was on top of the patch pending for inclusion into the -rc:s,
I can sure wait for that to be upstream and resend this then,
no hurry.

Yours,
Linus Walleij
