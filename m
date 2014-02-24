From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 11:04:23 +0100
Subject: [PATCH v4 01/16] pinctrl: mvebu: count unnamed controls and
 allocate name buffer
In-Reply-To: <1393165274-32492-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZAZL3_DEgEHmN+cCwbQaM3OU+xfDU35HiMuyc7zyky_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 3:20 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> pinctrl-mvebu allows SoCs to pass unnamed controls that will get an
> auto-generated name of "mpp<PIN#>". Currently, we are allocating name
> buffers on a per-control basis while looping over passed controls.
> This counts the total number of unnamed controls and allocates a
> global name buffer instead. The new buffer is then used while assigning
> controls to pinctrl groups later.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This v4 version applied.

Yours,
Linus Walleij
