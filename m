From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 15:59:48 +0100
Subject: [PATCH RFC v2 3/8] pinctrl: pinconf-generic: Add parameter 'IO
 standard'
In-Reply-To: <1413479495-14206-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdZtqNUroNfd_0Kftq+-056YFzjvR+ROrZZ0htZX2v2qzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> For HW that can select the IO standard for pins, add the infrastructure
> in pinconf generic to parse this parameter.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Nothing in this patch actually explain what an "IO standard" is,
which is paramount if it should be a generic property.

And if it should be generic, I really want to know why this is a
thing not overlapping with existing generic configs, and exactly
what it is and that it is probable other silicon will have it too.
And we need to discuss if it's the right name.

Looking at what you actually set up, it looks very much like this
is actually PIN_CONFIG_DRIVE_STRENGTH.

Yours,
Linus Walleij
